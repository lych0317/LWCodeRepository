//
//  LWHttpRequest.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "LWHttpRequest.h"
#import "LWHttpConfigure.h"
#import "LWHttpUploadFile.h"

@implementation LWHTTPSessionManager

+ (instancetype)sharedManager {
    static LWHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self manager];
    });
    return manager;
}

@end

@interface LWHttpRequest () {
    double _startRequestTime;
    double _endRequestTime;
}

/** 网络请求的域名或IP，默认使用主域名 */
@property (nonatomic, copy) NSString *httpServer;

/** 如果使用的是IP则需要传人host name, 用于设置http请求头 */
@property (nonatomic, copy) NSString *httpHostName;

/** url中"v3"之后"?"之前的字段，用来做key */
@property (nonatomic, copy) NSString *passKey;

/** 请求参数 */
@property (nonatomic, strong) NSDictionary *httpRequestData;

/** 请求任务 */
@property (nonatomic, strong) NSURLSessionDataTask *requestTask;

@end

@implementation LWHttpRequest

- (void)dealloc {
    HTTP_LOG(@"dealloc");
    [self stopAsyncRequest];
}

- (instancetype)initWithHttpServer:(NSString *)httpServer
                      httpHostName:(NSString *)httpHostName
                           passKey:(NSString *)passKey
                       requestData:(NSDictionary *)dicData
                          delegate:(id)delegate {
    self = [super init];
    if (self) {
        self.httpServer = httpServer;
        self.httpHostName = httpHostName;
        self.passKey = passKey;
        self.httpRequestData = dicData;
        self.delegate = delegate;

        _requestId = [self generateRequestIDWithPassKey:passKey requestData:dicData];
        _duration = 0;
    }

    return self;
}

- (void)startAsyncRequest {
    _startRequestTime = CFAbsoluteTimeGetCurrent() * 1000;
    HTTP_LOG(@"start request id %@ \nurl %@", self.requestId, [self getCommonHttpHead]);
}

- (void)stopAsyncRequest {
    if (self.requestTask) {
        [self.requestTask cancel];
    }
    HTTP_LOG(@"stop request id %@ \nurl %@", self.requestId, [self getCommonHttpHead]);
}

#pragma mark - handle common fun

- (NSString *)generateRequestIDWithPassKey:(NSString *)passKey requestData:(NSDictionary *)dicData {
    NSMutableDictionary *tempDic = [dicData mutableCopy];
    for (NSString *key in [tempDic allKeys]) {
        id obj = [tempDic objectForKey:key];
        if (![obj isString] && ![obj isNumber]) {
            [tempDic removeObjectForKey:key];
        }
    }

    if ([tempDic isValidDictionary]) {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:tempDic options:kNilOptions error:&error];
        if (error == nil) {
            NSString *jsonValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([jsonValue isValidString]) {
                NSString *sign = [jsonValue md5String];
                return [NSString stringWithFormat:@"%@_%@", passKey, sign];
            }
        }
    }

    return passKey;
}

/**
 *  获取common http head
 *
 *  @return url
 */
- (NSString *)getCommonHttpHead {
    NSString *strCommonHttpHead = @"";

    if ([self.httpServer isValidString]) {
        strCommonHttpHead = [strCommonHttpHead stringByAppendingString:self.httpServer];
        // pass
        strCommonHttpHead = [strCommonHttpHead stringByAppendingString:self.passKey];
    }

    return strCommonHttpHead;
}

- (AFHTTPSessionManager *)managerWithTimeOut:(NSTimeInterval)time {
    LWHTTPSessionManager *manager = [LWHTTPSessionManager sharedManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:time];
    [manager.requestSerializer setValue:@"4b35e1d82a7a665d2a3938ff351c506c" forHTTPHeaderField:@"apikey"];
    if ([self.httpHostName isValidString]) {
        [manager.requestSerializer setValue:self.httpHostName forHTTPHeaderField:@"host"];
    }
    HTTP_LOG(@"\nhttp \nurl %@ \nrequest headers %@", [self getCommonHttpHead], manager.requestSerializer.HTTPRequestHeaders);
    return manager;
}

#pragma mark - AFHTTPRequest methods

// 请求结束，获取 Response 数据
- (void)requestFinished:(NSURLSessionDataTask *)task response:(id)responseObject {
    _endRequestTime = CFAbsoluteTimeGetCurrent() * 1000;

    _duration = _endRequestTime - _startRequestTime;

    if (nil == responseObject) {
        return;
    }

    NSDictionary *header = nil;

    if (task.response && [task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        HTTP_LOG(@"\nhttp \nurl %@ \nresponse headers %@", task.originalRequest.URL.absoluteString, response.allHeaderFields);
        if ([response.allHeaderFields isValidDictionary]) {
            header = response.allHeaderFields;
        }
    }

    NSString *jsonValue = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

    NSDictionary *body = [jsonValue dictionary];

    HTTP_LOG(@"\nhttp \nurl %@ \nresponse body %@", task.originalRequest.URL.absoluteString, body);

    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(httpRequest:header:body:)]) {
        [self.delegate httpRequest:self header:header body:body];
    }
}

// 请求失败，获取 error
- (void)requestFailed:(NSURLSessionDataTask *)task requestError:(NSError *)error {
    _endRequestTime = CFAbsoluteTimeGetCurrent() * 1000;

    _duration = _endRequestTime - _startRequestTime;

    HTTP_LOG(@"\nhttp \nurl %@ \nerror %@", task.originalRequest.URL.absoluteString, error);

    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(httpRequest:error:)]) {
        [self.delegate httpRequest:self error:error];
    }
}

@end

@implementation LWHttpGetRequest

- (void)startAsyncRequest {
    [super startAsyncRequest];

    NSString *strURL = [self buildGetURLStr];

    AFHTTPSessionManager *manager = [self managerWithTimeOut:kTimeOutForHttpRequestGet];

    WS(weakSelf);

    self.requestTask = [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf requestFinished:task response:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf requestFailed:task requestError:error];
    }];
}

- (NSString *)buildGetURLStr {
    // common http head
    NSString *strHead = [self getCommonHttpHead];

    NSString *strData = @"";
    for (NSString *key in [self.httpRequestData allKeys]) {
        if ([key isValidString]) {
            id valueObj = [self.httpRequestData objectForKey:key];
            NSString *valueString = [self stringFromObj:valueObj];
            if ([valueString isValidString]) {
                valueString = [valueString urlEncode];
                strData = [strData stringByAppendingString:key];
                strData = [strData stringByAppendingString:@"="];
                strData = [strData stringByAppendingString:valueString];
                strData = [strData stringByAppendingString:@"&"];
            }
        }
    }

    // complete url str
    NSString *strCompleteURL = strHead;

    if ([strData isValidString]) {
        // 去掉最后一个"&"
        if ([[strData substringFromIndex:[strData length] - 1] isEqualToString:@"&"]) {
            strData = [strData substringToIndex:[strData length] - 1];
        }

        strCompleteURL = [NSString stringWithFormat:@"%@?%@", strHead, strData];
    }

    HTTP_LOG(@"get url = %@", strCompleteURL);

    return strCompleteURL;
}

//只支持NSNumber和NSString
- (NSString *)stringFromObj:(id)obj {
    if ([obj isString]) {
        return obj;
    }

    if ([obj isNumber]) {
        return [NSString stringWithFormat:@"%@", obj];
    }

    return nil;
}

@end

@implementation LWHttpPostRequest

- (void)startAsyncRequest {
    [super startAsyncRequest];

    NSString *strURL = [self getCommonHttpHead];

    AFHTTPSessionManager *manager = [self managerWithTimeOut:kTimeOutForHttpRequestPost];

    WS(weakSelf);

    HTTP_LOG(@"http request post data %@", self.httpRequestData);

    self.requestTask = [manager POST:strURL parameters:self.httpRequestData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf requestFinished:task response:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf requestFailed:task requestError:error];
    }];
}

@end

@implementation LWHttpUploadRequest

- (void)startAsyncRequest {
    [super startAsyncRequest];

    NSString *strURL = [self getCommonHttpHead];

    AFHTTPSessionManager *manager = [self managerWithTimeOut:kTimeOutForHttpRequestUpload];

    WS(weakSelf);

    NSDictionary *postData = [self getHttpUploadRequestData];

    HTTP_LOG(@"http request post data %@", self.httpRequestData);

    self.requestTask = [manager POST:strURL parameters:postData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *models = [self.httpRequestData objectForKey:HTTP_UPLOAD_WITH_FILES_KEY];
        if ([models isValidArray]) {
            for (int i = 0; i < models.count; i++) {
                LWHttpUploadFile *dataModel = models[i];
                if ([dataModel isKindOfClass:[LWHttpUploadFile class]]) {
                    if (dataModel.type == LWHttpUploadData) {
                        [formData appendPartWithFileData:dataModel.data
                                                    name:dataModel.name
                                                fileName:dataModel.fileName
                                                mimeType:dataModel.mimeType];
                    } else if (dataModel.type == LWHttpUploadLocalFile) {
                        [formData appendPartWithFileURL:[NSURL fileURLWithPath:dataModel.localPostFile]
                                                   name:dataModel.name
                                                  error:nil];
                    }
                }
            }
        }
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf requestFinished:task response:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf requestFailed:task requestError:error];
    }];
}

- (NSDictionary *)getHttpUploadRequestData {
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self.httpRequestData];
    [tempDic removeObjectForKey:HTTP_UPLOAD_WITH_FILES_KEY];
    return tempDic;
}

@end
