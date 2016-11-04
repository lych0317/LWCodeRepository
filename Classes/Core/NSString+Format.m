//
//  NSString+Format.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/4.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

- (NSDictionary *)dictionary {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *retDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return retDic;
}

@end
