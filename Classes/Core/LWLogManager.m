//
//  LWLogManager.m
//  LWCodeRepository
//
//  Created by leo.li on 16/10/31.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "LWLogManager.h"

static DDFileLogger *fileLogger = nil;

@implementation LWLogManager

+ (void)setupLog {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [DDLog addLogger:[DDASLLogger sharedInstance]];
        [DDLog addLogger:[DDTTYLogger sharedInstance]];

        if (KFileLogEnable) {
            fileLogger = [[DDFileLogger alloc] init];
            fileLogger.maximumFileSize = 2 * 1024 * 1024;           // 文件达到 2MB 回滚
            fileLogger.rollingFrequency = 0;                        // 忽略时间回滚
            fileLogger.logFileManager.maximumNumberOfLogFiles = 5;  // 最多 5 个日志文件

            [DDLog addLogger:fileLogger];
        }
    });
}

+ (NSString *)logMessage {
    if (KFileLogEnable && fileLogger) {
        NSArray *filePaths = [fileLogger.logFileManager sortedLogFilePaths];
        NSString *filePath = filePaths.count > 0 ? filePaths.lastObject : nil;
        NSError *error = nil;
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            return content;
        }
        return nil;
    }
    return nil;
}

@end
