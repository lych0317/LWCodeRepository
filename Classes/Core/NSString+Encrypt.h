//
//  NSString+Encrypt.h
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 加密处理
 */
@interface NSString (Encrypt)

/**
 *  @brief 利用sha1对字符串加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)shaString;

/**
 *  @brief 利用base64将字符串编码
 *
 *  @return 编码后的字符串
 */
- (NSString *)base64EncodeToString;

/**
 *  @brief 利用base64将字符串解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)base64DecodeToString;

/**
 *  @brief 利用base64将字符串编码
 *
 *  @return 编码后的data
 */
- (NSData *)base64EncodeToData;

/**
 *  @brief 生成md5
 *
 *  @return md5
 */
- (NSString *)md5String;

@end
