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
#import "PRViewController.h"
#import "LWPushPopViewController.h"
#import "LWDSLViewController.h"

@interface TableViewController ()

@property (nonatomic, copy) void (^cb)(void);

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *s = @"我是用来测试Unicode编码的";

    NSString *se = [s urlEncode];

    NSString *sd = [s urlDecode];

//    NSString *u = s; //[s stringByAddingPercentEscapesUsingEncoding:NSUTF16StringEncoding];
//
    NSString *su = [s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithRange:NSMakeRange(0, s.length)]];

    NSString *sss = [se stringByRemovingPercentEncoding];
//
//    BOOL b = [s canBeConvertedToEncoding:NSUnicodeStringEncoding];
//
//    char *c = [s cStringUsingEncoding:NSUnicodeStringEncoding];
//
//    printf("dddd%s    ", c);
//
//    NSData *d = [s dataUsingEncoding:NSUnicodeStringEncoding];
//
//    [d ]

//    NSString *sd = [NSPropertyListSerialization propertyListWithData:d options:NSPropertyListImmutable  format:NSPropertyListBinaryFormat_v1_0  error:NULL];

    LWLogInfo(@"s: %@ \nse: %@ \nsd: %@ \nsu: %@ \nsss: %@", s, se, sd, su, sss);

    self.cb = ^ {
        LWLogInfo(@"callback");
    };

    [self performSelector:@selector(test:) withObject:self.cb afterDelay:3];

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(test:) object:self.cb];
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //旧方法
    //    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    //新方法
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable  format:NULL  error:NULL];


    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (void)test:(void (^)(void))callback {
    LWLogInfo(@"test");
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
        else if (indexPath.row == 4) {
            [self.navigationController pushViewController:[[LWPushPopViewController alloc] init] animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[PRViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[[LWDSLViewController alloc] init] animated:YES];
        }
    }
}

@end
