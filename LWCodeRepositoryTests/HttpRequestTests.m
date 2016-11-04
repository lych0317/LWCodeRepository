//
//  HttpRequestTests.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/4.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LWHttpRequestManager.h"

#define WAIT do {\
[self expectationForNotification:@"RSBaseTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);

#define NOTIFY \
[[NSNotificationCenter defaultCenter] postNotificationName:@"RSBaseTest" object:nil];

@interface HttpRequestTests : XCTestCase

@end

@implementation HttpRequestTests

- (void)setUp {
    [super setUp];
    [LWLogManager setupLog];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGet {
    [[LWHttpRequestManager instance] startWithHttpMethod:LWHttpMethodGet passKey:@"weatherservice/citylist" requestData:@{@"cityname": @"北京"} resultBlock:^(NSDictionary *header, NSDictionary *body, NSError *error) {
        NOTIFY
    }];
    WAIT
}

@end
