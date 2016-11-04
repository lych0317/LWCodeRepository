//
//  LWHttpConfigure.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "LWHttpConfigure.h"

/** 线上环境 */
static NSString *kOnlineURL = @"http://apis.baidu.com/apistore/";

/** 测试环境 */
static NSString *kTestURL = @"http://60.205.59.6:8080/api/";

/** 开发环境 */
static NSString *kDeveloperURL = @"http://101.200.196.99:18080/api/";

@implementation LWHttpConfigure

- (instancetype)init {
    self = [super init];
    if (self) {
        self.environmental = kHttpServerEnvironmental;
        self.serverTest = kHttpServerTestMode;
    }
    return self;
}

+ (instancetype)sharedHttpConfigure {
    static LWHttpConfigure *httpConfigure = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpConfigure = [[LWHttpConfigure alloc] init];
    });
    return httpConfigure;
}

- (NSString *)httpServer {
    if (self.environmental) {
        return kOnlineURL;
    } else {
        if (self.serverTest) {
            return kDeveloperURL;
        } else {
            return kTestURL;
        }
    }
}

@end
