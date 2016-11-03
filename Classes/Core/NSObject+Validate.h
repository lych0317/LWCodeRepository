//
//  NSObject+Validate.h
//  LWCodeRepository
//
//  Created by leo.li on 16/10/31.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 验证类型
 */
@interface NSObject (Validate)

/**
 *  @brief 检测自己是否是number
 *
 *  @return YES：是number
 */
- (BOOL)isNumber;

/**
 *  @brief 检测自己是否是字符串
 *
 *  @return YES：是自字符串
 */
- (BOOL)isString;

/**
 *  @brief 检测自己是否是非空字符串
 *
 *  @return YES：是非空字符串
 */
- (BOOL)isValidString;

/**
 *  @brief 检测自己是否是集合
 *
 *  @return YES：是集合
 */
- (BOOL)isArray;

/**
 *  @brief 检测自己是否是非空集合
 *
 *  @return YES：是非空集合
 */
- (BOOL)isValidArray;

/**
 *  @brief 检测自己是否是字典
 *
 *  @return YES：是字典
 */
- (BOOL)isDictionary;

/**
 *  @brief 检测自己是否是非空字典
 *
 *  @return YES：是非空字典
 */
- (BOOL)isValidDictionary;

@end
