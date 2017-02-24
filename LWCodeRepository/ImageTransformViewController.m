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

@property (nonatomic, strong) UIView *animateImageView;
@property (nonatomic, strong) UIView *contatinerView;
@property (nonatomic, strong) CAShapeLayer *leftShapeLayer;
@property (nonatomic, strong) CAShapeLayer *rightShapeLayer;

@property (nonatomic, assign) BOOL b;

@end

@implementation ImageTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片旋转动画";

    self.isplay = NO;
    self.b = NO;

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


    CALayer *layer = [self lineAnimation];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.frame = CGRectMake(20, 200, 70, 26);
    layer.cornerRadius = 13;
    [self.view.layer addSublayer:layer];

    UIView *animateImageView = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 220, 220)];
    [self.view addSubview:animateImageView];
    self.animateImageView = animateImageView;

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 156, 156)];
    containerView.center = animateImageView.center;
    containerView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:containerView];
    self.contatinerView = containerView;

    UIImage *leftImage = [UIImage imageNamed:@"testImg"];
    UIImage *rightImage = [UIImage imageNamed:@"testImg1.jpeg"];

    containerView.layer.cornerRadius = 78;

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 156, 156)];
    [containerView addSubview:leftView];

    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 156, 156)];
    [containerView addSubview:rightView];

    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath addArcWithCenter:CGPointMake(78, 78) radius:78 startAngle:M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];

    CAShapeLayer *leftShapeLayer = [CAShapeLayer layer];
    self.leftShapeLayer = leftShapeLayer;
    leftShapeLayer.path = leftPath.CGPath;

    leftView.layer.contents = (__bridge id)leftImage.CGImage;
    leftView.layer.mask = leftShapeLayer;

    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath addArcWithCenter:CGPointMake(78, 78) radius:78 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];

    CAShapeLayer *rightShapeLayer = [CAShapeLayer layer];
    self.rightShapeLayer = rightShapeLayer;
    rightShapeLayer.path = rightPath.CGPath;

    rightView.layer.contents = (__bridge id)rightImage.CGImage;
    rightView.layer.mask = rightShapeLayer;

    [self animateWithAngle:270 animateIndex:0];
}

- (void)dealloc {
    LWLogInfo(@"dealloc");
}

- (void)animateWithAngle:(NSInteger)angle animateIndex:(NSInteger)index {
    CGFloat anchorAngleStart = (angle % 360 + 1) * M_PI / 180 - M_PI;
    CGFloat anchorAngleEnd = (angle % 360 - 1) * M_PI / 180;

    CGFloat micerAngleStart = (angle % 360 + 1) * M_PI / 180;
    CGFloat micerAngleEnd = (angle % 360 - 1) * M_PI / 180 + M_PI;

    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath addArcWithCenter:CGPointMake(78, 78) radius:77 startAngle:anchorAngleStart endAngle:anchorAngleEnd clockwise:YES];
    self.leftShapeLayer.path = leftPath.CGPath;

    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath addArcWithCenter:CGPointMake(78, 78) radius:77 startAngle:micerAngleStart endAngle:micerAngleEnd clockwise:YES];
    self.rightShapeLayer.path = rightPath.CGPath;

    if (index > 29) {
        index = 0;
    }
//    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"anim_head_%@@2x", @(index)] ofType:@"png"];
//    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.animateImageView.layer.contents = (__bridge id)[[UIImage imageNamed:[NSString stringWithFormat:@"anim_head_%@", @(index)]] CGImage];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateWithAngle:angle + 1 animateIndex:index + 1];
    });
}

- (void)trick {
}

- (CALayer *)lineAnimation{
    /*        创建模板层         */
    CAShapeLayer *shape           = [CAShapeLayer layer];
    shape.frame                   = CGRectMake(22, 10, 4, 6);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(4, 2)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path addArcWithCenter:CGPointMake(2, 5) radius:2 startAngle:0 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(0, 2)];
    [path addArcWithCenter:CGPointMake(2, 1) radius:2 startAngle:M_PI endAngle:M_PI * 2 clockwise:YES];

    shape.path                    = path.CGPath;
    shape.fillColor               = [[UIColor whiteColor] colorWithAlphaComponent:0.4].CGColor;
    [shape addAnimation:[self animationForScaleSmall] forKey:nil];
    [shape addAnimation:[self animationForScaleSmall2] forKey:nil];

    /*        创建克隆层的持有对象         */
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.instanceDelay      = 0.4;
    replicator.instanceCount      = 3;
    replicator.instanceTransform  = CATransform3DMakeTranslation(11, 0, 0);
    [replicator addSublayer:shape];

    return replicator;
}

- (CABasicAnimation *)animationForScaleSmall {
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform"];
    basic.fromValue         = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];
    basic.toValue           = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 0)];
    basic.duration          = 0.6;
    basic.repeatCount       = HUGE;
    basic.autoreverses      = YES;
    return basic;
}

- (CABasicAnimation *)animationForScaleSmall2 {
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    basic.fromValue         = (__bridge id _Nullable)([[UIColor whiteColor] colorWithAlphaComponent:0.4].CGColor);
    basic.toValue           = (__bridge id _Nullable)([[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor);
    basic.duration          = 0.6;
    basic.repeatCount       = HUGE;
    basic.autoreverses      = YES;
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
