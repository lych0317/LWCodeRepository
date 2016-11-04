//
//  LWHttpRequestManager.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "LWHttpRequestManager.h"

@interface LWHttpRequestManager () <LWHttpRequestDelegate>

/** 存放当前所有的http请求 */
@property (nonatomic, strong) NSMutableDictionary *httpRequestDic;

/** 存放当前所有的http请求的result block */
@property (nonatomic, strong) NSMutableDictionary *httpRequestResultBlockDic;

@end

@implementation LWHttpRequestManager

+ (LWHttpRequestManager *)instance {
    static LWHttpRequestManager *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[self alloc] init];
    });

    return g_instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.httpRequestDic = [NSMutableDictionary new];
        self.httpRequestResultBlockDic = [NSMutableDictionary new];
    }
    return self;
}

- (NSString *)startWithHttpServer:(NSString *)httpServer
                     httpHostName:(NSString *)httpHostName
                       HttpMethod:(LWHttpMethod)httpMethod
                          passKey:(NSString *)passKey
                      requestData:(NSDictionary *)dicData
                      resultBlock:(LWHttpRequestResultBlock)resultBlock {
    if ([passKey isValidString]) {
        LWHttpRequest *httpRequest = nil;

        if (httpMethod == LWHttpMethodGet) {
            httpRequest = [[LWHttpGetRequest alloc] initWithHttpServer:httpServer httpHostName:httpHostName passKey:passKey requestData:dicData delegate:self];
        } else if (httpMethod == LWHttpMethodPost) {
            httpRequest = [[LWHttpPostRequest alloc] initWithHttpServer:httpServer httpHostName:httpHostName passKey:passKey requestData:dicData delegate:self];
        } else if (httpMethod == LWHttpMethodUpload) {
            httpRequest = [[LWHttpUploadRequest alloc] initWithHttpServer:httpServer httpHostName:httpHostName passKey:passKey requestData:dicData delegate:self];
        }

        if (httpRequest) {
            @synchronized(self) {
                [self.httpRequestDic setValue:httpRequest forKey:httpRequest.requestId];
                if (resultBlock) {
                    [self.httpRequestResultBlockDic setValue:resultBlock forKey:httpRequest.requestId];
                }
            }

            [httpRequest startAsyncRequest];

            return httpRequest.requestId;
        }
    }
    return nil;
}

- (NSString *)startWithHttpMethod:(LWHttpMethod)httpMethod
                          passKey:(NSString *)passKey
                      requestData:(NSDictionary *)dicData
                      resultBlock:(LWHttpRequestResultBlock)resultBlock {
    NSString *httpServer = HTTP_SERVER;

    NSString *requestId = [self startWithHttpServer:httpServer
                                       httpHostName:nil
                                         HttpMethod:httpMethod
                                            passKey:passKey
                                        requestData:dicData
                                        resultBlock:resultBlock];

    return requestId;
}

- (void)stopHttpRequestWithRequestId:(NSString *)requestId {
    if ([requestId isValidString]) {
        LWHttpRequest *request = [self.httpRequestDic objectForKey:requestId];
        [request stopAsyncRequest];
        [self.httpRequestDic removeObjectForKey:requestId];
        [self.httpRequestResultBlockDic removeObjectForKey:requestId];
    }
}

#pragma mark - ULHttpRequest delegate

- (void)httpRequest:(LWHttpRequest *)request header:(NSDictionary *)header body:(NSDictionary *)body {
    LWHttpRequestResultBlock resultBlock = [self.httpRequestResultBlockDic objectForKey:request.requestId];

    if ([request.requestId isValidString]) {
        [self.httpRequestDic removeObjectForKey:request.requestId];
        [self.httpRequestResultBlockDic removeObjectForKey:request.requestId];
    }

    if (resultBlock) {
        resultBlock(header, body, nil);
    }
}

- (void)httpRequest:(LWHttpRequest *)request error:(NSError *)error {
    LWHttpRequestResultBlock resultBlock = [self.httpRequestResultBlockDic objectForKey:request.requestId];

    if ([request.requestId isValidString]) {
        [self.httpRequestDic removeObjectForKey:request.requestId];
        [self.httpRequestResultBlockDic removeObjectForKey:request.requestId];
    }

    if (resultBlock) {
        resultBlock(nil, nil, error);
    }
}

@end
