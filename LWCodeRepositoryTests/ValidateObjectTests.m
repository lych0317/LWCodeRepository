//
//  ValidateObjectTests.m
//  LWCodeRepository
//
//  Created by leo.li on 16/10/31.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <XCTest/XCTest.h>

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
    NSNumber *number = @5;
    XCTAssertTrue([number isNumber]);

    NSString *string = @"string";
    XCTAssertFalse([string isNumber]);
}

- (void)testString {
    NSString *string = @"";
    XCTAssertTrue([string isString]);
    XCTAssertFalse([string isValidString]);

    NSString *string1 = @"string";
    XCTAssertTrue([string1 isString]);
    XCTAssertTrue([string1 isValidString]);

    NSNumber *number = @5;
    XCTAssertFalse([number isString]);
}

- (void)testArray {
    NSArray *array = @[];
    XCTAssertTrue([array isArray]);
    XCTAssertFalse([array isValidArray]);

    NSArray *array1 = @[@5];
    XCTAssertTrue([array1 isArray]);
    XCTAssertTrue([array1 isValidArray]);

    NSDictionary *dictionary = @{};
    XCTAssertFalse([dictionary isArray]);
}

- (void)testDictionary {
    NSDictionary *dictionary = @{};
    XCTAssertTrue([dictionary isDictionary]);
    XCTAssertFalse([dictionary isValidDictionary]);

    NSDictionary *dictionary1 = @{@"5": @5};
    XCTAssertTrue([dictionary1 isDictionary]);
    XCTAssertTrue([dictionary1 isValidDictionary]);

    NSArray *array = @[];
    XCTAssertFalse([array isDictionary]);
}

@end
