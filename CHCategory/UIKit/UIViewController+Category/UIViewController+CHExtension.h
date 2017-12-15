//
//  UIViewController+CHExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 2016/11/25.
//  Copyright © 2016年 Guowen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CHExtension)

#pragma mark - Push

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewControllerWith:(NSString *)vcString animated:(BOOL)animated;

#pragma mark - Alert

- (void)alertViewWithTitle:(NSString *)title Message:(NSString *)message CancelButtonTitle:(NSString *)buttonTitle;

@end
