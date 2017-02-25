//
//  LWPushPopViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/24.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "LWPushPopViewController.h"
#import "ReactiveObjC.h"
#import "Masonry.h"
#import "LWPopViewController.h"
#import "LWPushPopTarget.h"

@interface LWPushPopViewController ()

@property (nonatomic, strong) LWPushPopTarget *pushPopTarget;

@end

@implementation LWPushPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pushPopTarget = [[LWPushPopTarget alloc] init];

    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"Push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    __weak LWPushPopViewController *weakSelf = self;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        weakSelf.navigationController.delegate = weakSelf.pushPopTarget;
        [weakSelf.navigationController pushViewController:[[LWPopViewController alloc] init] animated:YES];
    }];
    [self.view addSubview:button];

    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(84);
        make.right.equalTo(-20);
        make.height.equalTo(44);
    }];

    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor blueColor];
    redView.layer.cornerRadius = 50;
    [self.view addSubview:redView];
    self.redView = redView;
    [redView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-50);
        make.size.equalTo(100);
        make.centerX.equalTo(weakSelf.view);
    }];
}

@end
