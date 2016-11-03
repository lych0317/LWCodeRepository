//
//  NSString+URL.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)urlEncode {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));

    return encodedString;
}

- (NSString *)urlDecode {
    NSString *decodedString =
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                              (__bridge CFStringRef)self,
                                                                              CFSTR(""),
                                                                              CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    return decodedString;
}

- (NSDictionary *)queryItemDictionary {
    return [self queryItemDictionaryWithSeparator:@"&"];
}

- (NSDictionary *)queryItemDictionaryWithKeys:(NSArray *)keys {
    return [self queryItemDictionaryWithKeys:keys separator:@"&"];
}

- (NSDictionary *)queryItemDictionaryWithSeparator:(NSString *)separator {
    return [self queryItemDictionaryWithKeys:nil separator:separator];
}

- (NSDictionary *)queryItemDictionaryWithKeys:(NSArray *)keys separator:(NSString *)separator {
    NSMutableDictionary *queryItemDic = @{}.mutableCopy;
    if (self && ![self isEqualToString:@""]) {
        NSArray *queryArray = [self componentsSeparatedByString:separator];
        for (NSString *queryItem in queryArray) {
            NSRange seperateRange = [queryItem rangeOfString:@"="];
            if (seperateRange.length > 0 && seperateRange.location != NSNotFound) {
                NSString *key = [queryItem substringToIndex:seperateRange.location];
                if (![keys isValidArray] || [keys containsObject:key]) {
                    NSString *value = [queryItem substringFromIndex:seperateRange.location + seperateRange.length];
                    if ([value isValidString]) {
                        value = [value urlDecode];
                    }
                    [queryItemDic setValue:value forKey:key];
                }
            }
        }
    }
    return queryItemDic.copy;
}

@end
