//
//  NSString+Format.h
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/4.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

/**
 *  @brief 将字符串（json格式）转化成字典
 *
 *  @return 转化后的字典
 */
- (NSDictionary *)dictionary;

@end
