//
//  MasonryCrashViewController.m
//  LWCodeRepository
//
//  Created by yuanchao Li on 2017/3/20.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "MasonryCrashViewController.h"
#import <Masonry/Masonry.h>

@interface MasonryCrashViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MasonryCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.text = @"Title";
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        self.view = self;
        make.left.equalTo(self.view).with.offset(11);
        make.right.equalTo(self.view).offset(-8);
        make.top.equalTo(self.view).offset(120);
        make.bottom.equalTo(self.view).offset(-120);
    }];

}

@end
