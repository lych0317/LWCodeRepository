//
//  LWViewMaker.m
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/25.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "LWViewMaker.h"
#import "RACEXTScope.h"

@interface LWViewMaker ()

@property (nonatomic, strong) UIView *view;

@end

@implementation LWViewMaker

- (instancetype)initWithClass:(Class)aClass {
    self = [super init];
    if (self) {
        self.view = [[aClass alloc] init];
        @weakify(self)
        _backgroundColor = ^ LWViewMaker * (UIColor *color) {
            @strongify(self)
            self.view.backgroundColor = color;
            return self;
        };
        _position = ^ LWViewMaker * (CGFloat x, CGFloat y) {
            @strongify(self);
            self.view.center = CGPointMake(x, y);
            return self;
        };
        _size = ^ LWViewMaker * (CGFloat w, CGFloat h) {
            @strongify(self);
            self.view.bounds = CGRectMake(0, 0, w, h);
            return self;
        };
        _intoView = ^ id (UIView *superView) {
            @strongify(self);
            [superView addSubview:self.view];
            return self.view;
        };
    }
    return self;
}

- (void)dealloc {
    LWLogInfo(@"dealloc");
}

@end

LWViewMaker * alloc_view(Class aClass) {
    LWViewMaker *maker = [[LWViewMaker alloc] initWithClass:aClass];
    return maker;
}

