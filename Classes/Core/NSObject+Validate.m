//
//  NSObject+Validate.m
//  LWCodeRepository
//
//  Created by leo.li on 16/10/31.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "NSObject+Validate.h"

@implementation NSObject (Validate)

- (BOOL)isNumber {
    return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)isString {
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)isValidString {
    return [self isString] && ((NSString *)self).length > 0;
}

- (BOOL)isArray {
    return [self isKindOfClass:[NSArray class]];
}

- (BOOL)isValidArray {
    return [self isArray] && ((NSArray *)self).count > 0;
}

- (BOOL)isDictionary {
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)isValidDictionary {
    return [self isDictionary] && ((NSDictionary *)self).count > 0;
}

@end
