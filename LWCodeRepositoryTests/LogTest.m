//
//  LogTest.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LogTest : XCTestCase

@end

@implementation LogTest

- (void)setUp {
    [super setUp];
    [LWLogManager setupLog];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLog {
    LWLogDebug(@"debug");
    LWLogInfo(@"info");
    LWLogError(@"error");
}

@end
