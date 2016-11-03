//
//  NSString+URL.h
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 URL操作相关
 */
@interface NSString (URL)

/**
 *  @brief 针对URL编码
 *
 *  @return 编码后的字符串
 */
- (NSString *)urlEncode;

/**
 *  @brief 针对URL的解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)urlDecode;

/**
 解析所有参数，默认分隔符&

 @return 字典
 */
- (NSDictionary *)queryItemDictionary;

/**
 解析指定参数，默认分隔符&

 @param keys 指定key
 @return 字典
 */
- (NSDictionary *)queryItemDictionaryWithKeys:(NSArray *)keys;

/**
 解析所有参数，指定分割符

 @param separator 指定分隔符
 @return 字典
 */
- (NSDictionary *)queryItemDictionaryWithSeparator:(NSString *)separator;

/**
 解析指定参数，指定分隔符

 @param keys 指定参数
 @param separator 指定分隔符
 @return 字典
 */
- (NSDictionary *)queryItemDictionaryWithKeys:(NSArray *)keys separator:(NSString *)separator;

@end
