//
//  LWViewMaker.h
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/25.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"

@interface LWViewMaker : NSObject

@property (nonatomic, strong, readonly) LWViewMaker *with;
@property (nonatomic, copy) LWViewMaker * (^backgroundColor)(UIColor *color);
@property (nonatomic, copy) LWViewMaker * (^position)(CGFloat x, CGFloat y);
@property (nonatomic, copy) LWViewMaker * (^size)(CGFloat w, CGFloat h);
@property (nonatomic, copy) id (^intoView)(UIView *superView);

- (instancetype)initWithClass:(Class)aClass;

@end

#define AllocView(aClass) alloc_view([aClass class])

LWViewMaker * alloc_view(Class aClass);
