//
//  WebPImageViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/12/9.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "WebPImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+MultiFormat.h>

@interface WebPImageViewController ()

@end

@implementation WebPImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"webp图片";

    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];

    imageView.frame = CGRectMake(100, 100, 100, 100);

    NSURL *url = [NSURL URLWithString:@"http://img.hongrenshuo.com.cn/17627114782751479381272120.png"];

    [[SDImageCache sharedImageCache] removeImageForKey:url.absoluteString withCompletion:nil];

    [imageView sd_setImageWithURL:url];
}

@end
