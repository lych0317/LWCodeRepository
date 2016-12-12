//
//  TableViewController.m
//  LWCodeRepository
//
//  Created by leo.li on 2016/11/21.
//  Copyright © 2016年 liyc_dev. All rights reserved.
//

#import "TableViewController.h"
#import "CountViewController.h"
#import "MasonryViewController.h"
#import "WebPImageViewController.h"
#import "ImageTransformViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[CountViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[[MasonryViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 2) {
            [self.navigationController pushViewController:[[WebPImageViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 3) {
            [self.navigationController pushViewController:[[ImageTransformViewController alloc] init] animated:YES];
        }
    }
}

@end
