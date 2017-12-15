//
//  UIButton+CHExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 2016/12/14.
//  Copyright © 2016年 Guowen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CHButtonTapBlock)(UIButton *sender);


@interface UIButton (CHExtension)

@property (nonatomic,   copy) NSString *btnTitle;
@property (nonatomic, strong) UIFont *btnFont;
@property (nonatomic, strong) UIColor *btnTitleColor;
@property (nonatomic, strong) UIImage *btnBGImage;

@property (nonatomic, copy) void (^CHButtonTapBlock)(UIButton *sender);

@end
