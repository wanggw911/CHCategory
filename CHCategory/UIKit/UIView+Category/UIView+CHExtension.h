//
//  UIView+CHExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 2016/12/14.
//  Copyright © 2016年 Guowen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIViewTapActionBlock)(void);

@interface UIView (CHExtension)

#pragma mark - Factory

+ (UIView *_Nullable)ch_line;

+ (UIView *_Nullable)ch_tableHeaderFooterView;

+ (UILabel *_Nullable)ch_labelWithBgColor:(UIColor *_Nullable)bgColor
                                     font:(UIFont *_Nullable)font
                                     text:(NSString *_Nullable)text
                                textColor:(UIColor *_Nullable)textColor
                            textAlignment:(NSNumber *_Nullable)alignment;

+ (UIButton *_Nullable)ch_buttonWithBgColor:(UIColor *_Nullable)bgColor
                                       font:(UIFont *_Nullable)font
                                       text:(NSString *_Nullable)text
                                  textColor:(UIColor *_Nullable)textColor
                                     target:(nullable id)target
                                     action:(nullable SEL)action;

#pragma mark - Animation

- (void)ch_shakeView;

- (void)ch_shakeRotation:(CGFloat)rotation;

#pragma mark - Runtime

- (void)ch_tapActionHandler:(UIViewTapActionBlock _Nullable)block;

- (void)ch_touchActionHandler:(void (^_Nullable)(void))block;

@end
