//
//  URLStringTests.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface URLStringTests : XCTestCase

@end

@implementation URLStringTests

- (void)setUp {
    [super setUp];
    [LWLogManager setupLog];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEncode {
    NSString *url = @"https://www.baidu.com/s?ie=UTF-8&wd=xocde 8 注释 vvdocument";
    LWLogInfo(@"encode url: %@", [url urlEncode]);
}

- (void)testDecode {
    NSString *url = @"https://www.baidu.com/s?ie=UTF-8&wd=xocde%208%20%E6%B3%A8%E9%87%8A%20vvdocument";
    LWLogInfo(@"decode url: %@", [url urlDecode]);
}

- (void)testQueryItemDictionary {
    NSString *query = @"ie=UTF-8&wd=xocde%208%20%E6%B3%A8%E9%87%8A%20vvdocument";
    LWLogInfo(@"all key %@", [query queryItemDictionary]);

    LWLogInfo(@"key=wd %@", [query queryItemDictionaryWithKeys:@[@"wd"]]);

    NSString *query2 = @"ie=UTF-8&wd=xocde 8 注释 vvdocument";
    LWLogInfo(@"all key with & %@", [query2 queryItemDictionaryWithSeparator:@"&"]);

    LWLogInfo(@"key=wd with & %@", [query2 queryItemDictionaryWithKeys:@[@"wd"] separator:@"&"]);
}

@end
