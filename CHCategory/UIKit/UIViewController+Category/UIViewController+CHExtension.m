//
//  UIViewController+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 2016/11/25.
//  Copyright © 2016年 Guowen Wang. All rights reserved.
//

#import "UIViewController+CHExtension.h"

@implementation UIViewController (CHExtension)

#pragma mark - Push

- (void)pushViewControllerWith:(NSString *)vcString animated:(BOOL)animated {
    UIViewController *viewController = [[NSClassFromString([NSString stringWithFormat:@"%@",vcString]) alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

#pragma mark - Alert

- (void)alertViewWithTitle:(NSString *)title Message:(NSString *)message CancelButtonTitle:(NSString *)buttonTitle {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:buttonTitle
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
