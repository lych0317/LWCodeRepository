//
//  LWDSLViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/25.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "LWDSLViewController.h"
#import "LWViewMaker.h"
#import "ReactiveObjC.h"

@interface LWDSLViewController ()

@end

@implementation LWDSLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    AllocView(UIView).backgroundColor([UIColor redColor]).position(100, 200).size(100, 100).intoView(self.view);

    UIButton *button = AllocView(UIButton).backgroundColor([UIColor blueColor]).position(100, 350).size(100, 100).intoView(self.view);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"AlertView" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
            LWLogInfo(@"点击 %@", x);
        }];
        [alertView show];
    }];
}

- (void)dealloc {
    LWLogInfo(@"dealloc");
}

@end
