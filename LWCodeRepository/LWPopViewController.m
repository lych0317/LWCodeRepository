//
//  LWPopViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/24.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "LWPopViewController.h"
#import "LWPushPopAnimation.h"

@interface LWPopViewController ()

@end

@implementation LWPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    LWLogInfo(@"1 %@", self.navigationController);
    self.navigationController.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    LWLogInfo(@"2 %@", self.navigationController);
}

@end
