//
//  UITextField+CHExtension.m
//  BuyerShow
//
//  Created by Guowen Wang on 2017/3/4.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import "UITextField+CHExtension.h"

@implementation UITextField (CHExtension)
@dynamic placeholderColor;

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

@end
