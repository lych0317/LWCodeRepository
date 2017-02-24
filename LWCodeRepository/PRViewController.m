//
//  PRViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/23.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "PRViewController.h"
#import "ReactiveObjC.h"
#import "Masonry.h"

@interface PRViewController ()

@end

@implementation PRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSArray *array = @[@1, @2, @3];
    id number = [[[[array rac_sequence] map:^id _Nullable(id  _Nullable value) {
        return @([value intValue] * 2);
    }] filter:^BOOL(id  _Nullable value) {
        return [value intValue] >= 4;
    }] foldLeftWithStart:@0 reduce:^id _Nullable(id  _Nullable accumulator, id  _Nullable value) {
        return @([accumulator intValue] + [value intValue]);
    }];

    LWLogInfo(@"%@", number);

    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"Reactive" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"AlertView" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
            LWLogInfo(@"点击 %@", x);
        }];
        [alertView show];
    }];
    [self.view addSubview:button];

    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(84);
        make.right.equalTo(-20);
        make.height.equalTo(44);
    }];
}

@end
