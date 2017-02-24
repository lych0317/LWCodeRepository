//
//  LWPushPopTarget.m
//  LWCodeRepository
//
//  Created by leo.li on 2017/2/24.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "LWPushPopTarget.h"
#import "LWPushPopAnimation.h"

@implementation LWPushPopTarget

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    LWLogInfo(@"%@, %@, %@, %@", navigationController, @(operation), fromVC, toVC);
    LWPushPopAnimation *animator = [LWPushPopAnimation new];
    animator.push = (operation == UINavigationControllerOperationPush);
    return animator;
}

@end
