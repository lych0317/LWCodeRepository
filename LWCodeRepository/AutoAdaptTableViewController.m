//
//  AutoAdaptTableViewController.m
//  LWCodeRepository
//
//  Created by yuanchao Li on 2017/5/22.
//  Copyright © 2017年 liyc_dev. All rights reserved.
//

#import "AutoAdaptTableViewController.h"
#import <Masonry/Masonry.h>

@interface AutoAdaptTableViewController ()

@end

@implementation AutoAdaptTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.contentView.backgroundColor = [UIColor blueColor];

        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:view];

        [view makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(30, 30));
            make.top.equalTo(@5);
            make.bottom.equalTo(@-5);
            make.left.equalTo(@5);
        }];
    }
    

    return cell;
}

@end
