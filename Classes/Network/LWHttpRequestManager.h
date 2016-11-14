//
//  LWHttpRequestManager.h
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWHttpRequest.h"
#import "LWHttpConfigure.h"
#import "LWHttpUploadFile.h"

/** 网络请求返回结果的block */
typedef void(^LWHttpRequestResultBlock)(NSDictionary *header, NSDictionary *body, NSError *error);

/**
 * 网络请求工具类
 */
@interface LWHttpRequestManager : NSObject

/**
 *  单例
 */
+ (LWHttpRequestManager *)instance;

/**
 *  发起网络请求
 *
 *  @param httpMethod  请求方式：get or post
 *  @param passKey     请求的passkey eg:/im/config_version(url中"v3"之后"?"之前的字段)
 *  @param dicData     请求数据
 *  @param resultBlock result block
 *
 *  @return request id，用于stop当前请求
 */
- (NSString *)startWithHttpMethod:(LWHttpMethod)httpMethod
                          passKey:(NSString *)passKey
                      requestData:(NSDictionary *)dicData
                      resultBlock:(LWHttpRequestResultBlock)resultBlock;

/**
 *  发起网络请求
 *
 *  @param httpMethod  请求方式：get or post
 *  @param server      server
 *  @param passKey     请求的passkey eg:/im/config_version(url中"v3"之后"?"之前的字段)
 *  @param dicData     请求数据
 *  @param resultBlock result block
 *
 *  @return request id，用于stop当前请求
 */
- (NSString *)startWithHttpMethod:(LWHttpMethod)httpMethod
                           server:(NSString *)server
                          passKey:(NSString *)passKey
                      requestData:(NSDictionary *)dicData
                      resultBlock:(LWHttpRequestResultBlock)resultBlock;

/**
 *  停止网络请求
 *
 *  @param requestId 要停止的网络请求的request id
 */
- (void)stopHttpRequestWithRequestId:(NSString *)requestId;

@end
