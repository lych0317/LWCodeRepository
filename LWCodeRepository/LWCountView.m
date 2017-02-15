//
//  LWCountView.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/21.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "LWCountView.h"
#import <Masonry.h>

@interface LWCountView ()

@property (nonatomic, weak) UILabel *decreaseLabel;
@property (nonatomic, weak) UILabel *displayLabel;
@property (nonatomic, weak) UILabel *increaseLabel;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign, getter=isLongPressed) BOOL longPress;

@end

@implementation LWCountView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.count = 0;

        UILabel *decreaseLabel = [[UILabel alloc] init];
        decreaseLabel.text = @"➖";
        decreaseLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:decreaseLabel];
        self.decreaseLabel = decreaseLabel;

        UILabel *displayLabel = [[UILabel alloc] init];
        displayLabel.text = [@(self.count) stringValue];
        displayLabel.textAlignment = NSTextAlignmentCenter;
        displayLabel.textColor = [UIColor redColor];
        [self addSubview:displayLabel];
        self.displayLabel = displayLabel;

        UILabel *increaseLabel = [[UILabel alloc] init];
        increaseLabel.text = @"➕";
        increaseLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:increaseLabel];
        self.increaseLabel = increaseLabel;

        [decreaseLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
        }];

        [displayLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.centerX.equalTo(0);
            make.left.equalTo(decreaseLabel.right);
            make.right.equalTo(increaseLabel.left);
        }];

        [increaseLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(0);
        }];

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];

        [self addGestureRecognizer:tapGesture];
        [self addGestureRecognizer:longPressGesture];

//        __weak typeof(LWCountView *) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LWLogInfo(@"hahahha %@", self);
        });


//        [self performSelector:@selector(test) withObject:nil afterDelay:10];
    }
    return self;
}

- (void)test {
    LWLogInfo(@"hahahah %@", self);
}

- (void)tapGestureAction:(UITapGestureRecognizer *)action {
    CGPoint tapPoint = [action locationInView:self];
    if (CGRectContainsPoint(self.decreaseLabel.frame, tapPoint)) {
        self.count--;
    } else if (CGRectContainsPoint(self.increaseLabel.frame, tapPoint)) {
        self.count++;
    }
    self.displayLabel.text = [@(self.count) stringValue];
}

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)action {
    CGPoint tapPoint = [action locationInView:self];
    if (CGRectContainsPoint(self.decreaseLabel.frame, tapPoint)) {
        if (action.state == UIGestureRecognizerStateBegan) {
            self.longPress = YES;
            [self decrease:1];
        } else if (action.state == UIGestureRecognizerStateEnded) {
            self.longPress = NO;
        }
    } else if (CGRectContainsPoint(self.increaseLabel.frame, tapPoint)) {
        if (action.state == UIGestureRecognizerStateBegan) {
            self.longPress = YES;
            [self increase:1];
        } else if (action.state == UIGestureRecognizerStateEnded) {
            self.longPress = NO;
        }
    }
}


- (void)decrease:(NSTimeInterval)time {
    if (!self.isLongPressed) {
        return;
    }
    self.count--;
    self.displayLabel.text = [@(self.count) stringValue];

    WS(weakSelf)
    time *= 0.9;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf decrease:time];
    });
}

- (void)increase:(NSTimeInterval)time {
    if (!self.isLongPressed) {
        return;
    }
    self.count++;
    self.displayLabel.text = [@(self.count) stringValue];

    WS(weakSelf)
    time *= 0.9;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf increase:time];
    });
}

- (void)cancel {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(test) object:nil];
}

- (void)dealloc {
    LWLogInfo(@"count view dealloc");
}

@end
