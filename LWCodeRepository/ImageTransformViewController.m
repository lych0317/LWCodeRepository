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

@property (nonatomic, strong) UIView *contatinerView;

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


//    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 50, 100)];
//    containerView.backgroundColor = [UIColor redColor];
//    containerView.clipsToBounds = YES;
//    [self.view addSubview:containerView];
//    self.contatinerView = containerView;
//
//    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    imageView1.image = [UIImage imageNamed:@"testImg"];
//    imageView1.layer.cornerRadius = 50;
//    imageView1.layer.masksToBounds = YES;
//    [containerView addSubview:imageView1];

    CALayer *layer = [self lineAnimation];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.frame = CGRectMake(20, 200, 70, 26);
    layer.cornerRadius = 13;
    [self.view.layer addSublayer:layer];
}

- (CALayer *)lineAnimation{
    /*        创建模板层         */
    CAShapeLayer *shape           = [CAShapeLayer layer];
    shape.frame                   = CGRectMake(15, 10, 4, 6);
    shape.path                    = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 4, 6)].CGPath;
    shape.fillColor               = [UIColor whiteColor].CGColor;
    [shape addAnimation:[self animationForScaleSmall] forKey:nil];

    /*        创建克隆层的持有对象         */
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.instanceDelay      = 0.5;
    replicator.instanceCount      = 3;
    replicator.instanceTransform  = CATransform3DMakeTranslation(15, 0, 0);
    [replicator addSublayer:shape];

    return replicator;
}

- (CABasicAnimation *)animationForScaleSmall{
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform"];
    basic.fromValue         = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];
    basic.toValue           = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 0)];
    basic.duration          = 0.8;
    basic.repeatCount       = HUGE;
    return basic;
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
