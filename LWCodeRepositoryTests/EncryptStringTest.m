//
//  EncryptStringTest.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface EncryptStringTest : XCTestCase

@end

@implementation EncryptStringTest

- (void)setUp {
    [super setUp];
    [LWLogManager setupLog];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSha {
    NSString *string = @"abcdefgh";

    LWLogInfo(@"sha: %@", [string shaString]);
}

- (void)testBase64 {
    NSString *string = @"abcdefgh";

    LWLogInfo(@"base64 encode to string %@", [string base64EncodeToString]);

    LWLogInfo(@"base64 decode to string %@", [[string base64EncodeToString] base64DecodeToString]);

    LWLogInfo(@"base64 encode to data %@", [string base64EncodeToData]);
}

- (void)testMd5 {
    NSString *string = @"abcdefgh";

    LWLogInfo(@"md5: %@", [string md5String]);
}

@end
