//
//  LWHttpUploadFile.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/3.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "LWHttpUploadFile.h"

@implementation LWHttpUploadFile

- (id)initWithData:(NSData *)data
              name:(NSString *)name
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType {
    self = [super init];
    if (self) {
        self.type = LWHttpUploadData;
        self.data = data;
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mimeType;
    }
    return self;
}

- (id)initWithLocalPostFile:(NSString *)localPostFile
                       name:(NSString *)name {
    self = [super init];
    if (self) {
        self.type = LWHttpUploadLocalFile;
        self.localPostFile = localPostFile;
        self.name = name;
    }
    return self;
}

@end
