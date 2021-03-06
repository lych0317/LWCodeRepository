//
//  LWLogManager.h
//  LWCodeRepository
//
//  Created by leo.li on 16/10/31.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#define KFileLogEnable 1

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelAll;
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#ifndef LWLogError
#define LWLogError(fmt, ...) DDLogError((@"[LWLOG] [ERROR] [FUNCTION %s Line %d.]\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef LWLogInfo
#define LWLogInfo(fmt, ...) DDLogInfo((@"[LWLOG] [INFO] [FUNCTION %s Line %d.]\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef LWLogDebug
#define LWLogDebug(fmt, ...) DDLogDebug((@"[LWLOG] [DEBUG] [FUNCTION %s Line %d.]\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef NSLog
#define NSLog(fmt, ...) LWLogDebug(fmt, ...)
#endif

/**
 日志管理系统
 */
@interface LWLogManager : NSObject

/**
 设置日志系统
 */
+ (void)setupLog;


/**
 获取文件中存储的日志

 @return 字符串
 */
+ (NSString *)logMessage;

@end
