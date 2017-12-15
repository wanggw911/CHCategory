//
//  UIButton+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 2016/12/14.
//  Copyright © 2016年 Guowen Wang. All rights reserved.
//

#import "UIButton+CHExtension.h"
#import <objc/runtime.h>

static char key_buttonTap;


@implementation UIButton (CHExtension)
@dynamic btnFont;
@dynamic btnTitle;
@dynamic btnTitleColor;
@dynamic btnBGImage;
@dynamic CHButtonTapBlock;

- (void)setBtnFont:(UIFont *)btnFont {
    self.titleLabel.font = btnFont;
}

- (void)setBtnTitle:(NSString *)btnTitle {
    [self setTitle:btnTitle forState:UIControlStateNormal];
}

- (void)setBtnTitleColor:(UIColor *)btnTitleColor {
    [self setTitleColor:btnTitleColor forState:UIControlStateNormal];
}

- (void)setBtnBGImage:(UIImage *)btnBGImage {
    [self setBackgroundImage:btnBGImage forState:UIControlStateNormal];
}

- (void)setCHButtonTapBlock:(void (^)(UIButton *))buttonTapBlock {
    [self addTarget:self action:@selector(buttonTapAction:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, &key_buttonTap, buttonTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)buttonTapAction:(UIButton *)sender {
    CHButtonTapBlock block = objc_getAssociatedObject(self, &key_buttonTap);
    if (block) {
        block(sender);
    }
}

@end
