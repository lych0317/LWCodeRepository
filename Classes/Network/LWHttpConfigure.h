//
//  LWHttpConfigure.h
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 服务器环境(1:正式环境) (0:测试环境) */
static NSInteger kHttpServerEnvironmental = 1;

/** 服务器测试环境(1: 101 来自服务端) (0: 60 来自测试) */
static NSInteger kHttpServerTestMode = 0;

/** HTTP Get请求超时 */
static const NSTimeInterval kTimeOutForHttpRequestGet = 10;

/** HTTP post请求超时 */
static const NSTimeInterval kTimeOutForHttpRequestPost = 20;

/** HTTP upload请求超时 */
static const NSTimeInterval kTimeOutForHttpRequestUpload = 30;

// 上传文件的key，提交网络请求时的数据key, 对应的值必须是ULHttpUploadModel对象数组
#define HTTP_UPLOAD_WITH_FILES_KEY        @"multipartFile"

// 服务端版本
#define HTTP_VERSION @"7"

#define HTTP_CONFIGURE [LWHttpConfigure sharedHttpConfigure]

#define HTTP_SERVER [HTTP_CONFIGURE httpServer]

#define HTTP_LOG_ENABLE 1

#if HTTP_LOG_ENABLE
#define HTTP_LOG(fmt, ...) LWLogInfo(fmt, ##__VA_ARGS__)
#else
#define HTTP_LOG(fmt, ...) //
#endif

/**
 *  配置网络请求
 */
@interface LWHttpConfigure : NSObject

/** 环境配置 */
@property (nonatomic, assign) NSInteger environmental;
@property (nonatomic, assign) NSInteger serverTest;

/**
 *  @brief 获取单例对象
 *
 *  @return config对象
 */
+ (instancetype)sharedHttpConfigure;

/**
 *  @brief 服务URL
 *
 *  @return URL
 */
- (NSString *)httpServer;

@end
