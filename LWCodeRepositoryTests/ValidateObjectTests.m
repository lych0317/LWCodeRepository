//
//  ValidateObjectTests.m
//  LWCodeRepository
//
//  Created by leo.li on 16/10/31.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+Validate.h"

@interface ValidateObjectTests : XCTestCase

@end

@implementation ValidateObjectTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNumber {
    NSNumber *number = [NSNumber numberWithInt:5];
    XCTAssertTrue([number isNumber]);

    NSString *string = @"string";
    XCTAssertFalse([string isNumber]);
}



- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
