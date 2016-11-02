//
//  ViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 16/10/28.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

    blueView.frame = CGRectMake(0, 0, 320, 200);

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
    __weak ViewController *weakSelf = self;
    [UIView animateWithDuration:1 animations:^{
        weakSelf.blueView.frame = CGRectMake(100, 100, 200, 200);
        [weakSelf.blueView.superview layoutIfNeeded];
    }];
}

@end
