//
//  CountViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/12/9.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "CountViewController.h"
#import "LWCountView.h"

@interface CountViewController ()

@property (nonatomic, strong) LWCountView *countView;

@end

@implementation CountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计数View";
    self.view.backgroundColor = [UIColor whiteColor];
    LWCountView *countView = [[LWCountView alloc] init];
    countView.frame = CGRectMake(100, 300, 200, 44);
    [self.view addSubview:countView];
    self.countView = countView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

//    self.countView = nil;
//
//    LWLogInfo(@"count view %@", self.countView);
}

@end
