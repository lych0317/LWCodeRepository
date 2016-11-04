//
//  LWHttpRequest.h
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

/** 请求方式 */
typedef NS_ENUM (NSInteger, LWHttpMethod) {
    /** get */
    LWHttpMethodGet = 0,
    /** post */
    LWHttpMethodPost = 1,
    /** upload */
    LWHttpMethodUpload = 2,
};

@interface LWHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end


@class LWHttpRequest;

/**
 *  网络请求单元代理
 */
@protocol LWHttpRequestDelegate <NSObject>

/**
 *  @brief 请求成功
 *
 *  @param request 请求
 *  @param header  头
 *  @param body    体
 */
- (void)httpRequest:(LWHttpRequest *)request header:(NSDictionary *)header body:(NSDictionary *)body;

/**
 *  @brief 请求失败
 *
 *  @param request 请求
 *  @param error   错误
 */
- (void)httpRequest:(LWHttpRequest *)request error:(NSError *)error;

@end

/**
 *  网络请求单元
 */
@interface LWHttpRequest : NSObject

/** 代理 */
@property (nonatomic, weak) id<LWHttpRequestDelegate> delegate;

/** 请求时间 */
@property (nonatomic, readonly, assign) NSInteger duration;

/** 请求ID */
@property (nonatomic, readonly, copy) NSString *requestId;

/**
 *  发起网络请求
 *
 *  @param httpServer http server
 *  @param httpHostName 如果httpServer传人的是IP,则需要同时传递httpHostName用于设置请求头
 *  @param passKey    请求的passkey eg:/im/config_version(url中"v3"之后"?"之前的字段)
 *  @param dicData    请求数据
 *  @param delegate   request delegate
 *
 *  @return 实例
 */
- (instancetype)initWithHttpServer:(NSString *)httpServer
                      httpHostName:(NSString *)httpHostName
                           passKey:(NSString *)passKey
                       requestData:(NSDictionary *)dicData
                          delegate:(id)delegate;

/**
 *  @brief 发起网络异步请求
 */
- (void)startAsyncRequest;

/**
 *  @brief 停止网络异步请求
 */
- (void)stopAsyncRequest;

@end

/**
 *  GET请求
 */
@interface LWHttpGetRequest : LWHttpRequest

@end

/**
 *  POST请求
 */
@interface LWHttpPostRequest : LWHttpRequest

@end

/**
 *  UPLOAD请求
 */
@interface LWHttpUploadRequest : LWHttpRequest

@end
