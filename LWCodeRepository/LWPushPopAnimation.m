//
//  LWPushPopAnimation.m
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/24.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "LWPushPopAnimation.h"
#import "LWPushPopViewController.h"
#import "LWPopViewController.h"

@implementation LWPushPopAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.push) {
        LWPopViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        LWPushPopViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];

        toViewController.view.frame = fromViewController.redView.frame;

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.frame = fromViewController.view.frame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else {
        LWPushPopViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        LWPopViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] addSubview:fromViewController.view];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.frame = toViewController.redView.frame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
