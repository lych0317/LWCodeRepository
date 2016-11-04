//
//  LWHttpUploadFile.h
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 上传文件类型 */
typedef NS_ENUM (NSInteger, LWHttpUploadFileType) {
    /** 二进制数据 */
    LWHttpUploadData = 1,
    /** 本地文件 */
    LWHttpUploadLocalFile = 2,
};

/**
 *  @brief 数据模型：用于HTTP上传“文件”或“二进制数据”
 */
@interface LWHttpUploadFile : NSObject

/** 上传的类型, 二进制数据或本地文件 */
@property (nonatomic, assign) LWHttpUploadFileType type;

/** 如果上传的类型为ULSHttpUploadData时，需设置该字段以指定二进制数据 */
@property (nonatomic, strong) NSData *data;

/** 如果上传的类型为ULSHttpUploadLocalFile时，需设置该字段以指定本地文件路径 */
@property (nonatomic, strong) NSString *localPostFile;

/** 服务端要解析的data的key */
@property (nonatomic, copy) NSString *name;

/** 服务端要存储的文件名称 */
@property (nonatomic, copy) NSString *fileName;

/** 上传的文件类型 */
@property (nonatomic, copy) NSString *mimeType;

/**
 *  @brief 初始化
 *
 *  @param data 二进制数据：NSData类型
 *  @param name 服务端要解析的data的key
 *  @param fileName 服务端要存储的文件名称
 *  @param　mimeType 文件类型
 */
- (id)initWithData:(NSData *)data
              name:(NSString *)name
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType;

/**
 *  @brief 初始化
 *
 *  @param localPostFile 本地文件路径
 *  @param name 服务端要解析的data的key
 */
- (id)initWithLocalPostFile:(NSString *)localPostFile
                       name:(NSString *)name;

@end
