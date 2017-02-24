//
//  MasonryViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/12/9.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "MasonryViewController.h"
#import "Masonry.h"

@interface MasonryViewController ()

@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) UIView *blueView;

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"masonry+frame动画";

    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"start" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@44);
    }];

    UIView *blueView = [[UIView alloc] init];
    [self.view addSubview:blueView];

    self.blueView = blueView;
    blueView.backgroundColor = [UIColor blueColor];

    blueView.frame = CGRectMake(15, 70, self.view.frame.size.width - 30, 200);

    UIView *redView = [[UIView alloc] init];
    [self.blueView addSubview:redView];

    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;

    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@100);
    }];
}

- (void)buttonAction:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        self.blueView.frame = CGRectMake(100, 100, 200, 200);
        [self.blueView.superview layoutIfNeeded];
    }];
}

@end
