//
//  ImageTransformViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/12/9.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "ImageTransformViewController.h"

@interface ImageTransformViewController ()

@property (nonatomic, assign) BOOL isplay;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ImageTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片旋转动画";

    self.isplay = NO;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testImg"]];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    //圆角
    self.imageView.frame = CGRectMake(100, 100, 50, 50);
    self.imageView.layer.cornerRadius = 50 / 2.0;
    self.imageView.layer.masksToBounds = YES;

    //添加动画
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
    monkeyAnimation.duration = 12;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO; //No Remove

    monkeyAnimation.repeatCount = FLT_MAX;
    [self.imageView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    [self.imageView stopAnimating];

    // 加载动画 但不播放动画
    self.imageView.layer.speed = 0.0;

    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 35)];
    [startButton addTarget:self action:@selector(startAnimate:) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    startButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:startButton];

    UIButton *pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 50, 35)];
    [pauseButton addTarget:self action:@selector(pauseAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
    pauseButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:pauseButton];
}

//开始动画
- (void)startAnimate:(id)sender {
    if (!self.isplay) {
        self.isplay = YES;
        self.imageView.layer.speed = 1.0;
        self.imageView.layer.beginTime = 0.0;
        CFTimeInterval pausedTime = [self.imageView.layer timeOffset];
        CFTimeInterval timeSincePause = [self.imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.imageView.layer.beginTime = timeSincePause;
    }


}
//停止动画并保存当前的角度
- (void)pauseAnimation:(id)sender {
    if (self.isplay) {
        self.isplay = NO;
        CFTimeInterval pausedTime = [self.imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.imageView.layer.speed = 0.0;
        self.imageView.layer.timeOffset = pausedTime;
    }

}

@end
