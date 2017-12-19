//
//  UIView+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 2016/12/14.
//  Copyright © 2016年 Guowen Wang. All rights reserved.
//

#import "UIView+CHExtension.h"
#import <objc/runtime.h>//获取运行时

static char Key_UIViewTapAction;
static inline CAKeyframeAnimation * CHUIViewScalingAnimation() {
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animate.duration = 0.3;
    animate.removedOnCompletion = YES;
    animate.fillMode = kCAFillModeForwards;
    
    animate.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)],
                       [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)],
                       [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)],
                       [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    return animate;
}

@implementation UIView (CHExtension)

#pragma mark - Factory

+ (UIView *)ch_line {
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    return line;
}

+ (UIView *)ch_tableHeaderFooterView {
    UIView *head = [UIView new];
    head.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return head;
}

+ (UILabel *)ch_labelWithBgColor:(UIColor *)bgColor
                            font:(UIFont *)font
                            text:(NSString *)text
                       textColor:(UIColor *)textColor
                   textAlignment:(NSNumber *)alignment {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = bgColor ? bgColor : [UIColor whiteColor];
    label.font = font ? font : [UIFont systemFontOfSize:15];
    label.text = text.length > 0 ? text : @"";
    label.textColor = textColor ? textColor : [UIColor blackColor];
    label.textAlignment = alignment ? alignment.integerValue : NSTextAlignmentLeft;
    
    return label;
}

+ (UIButton *)ch_buttonWithBgColor:(UIColor *)bgColor
                              font:(UIFont *)font
                              text:(NSString *)text
                         textColor:(UIColor *)textColor
                            target:(nullable id)target
                            action:(nullable SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = bgColor ? bgColor : [UIColor whiteColor];
    button.titleLabel.font = font ? font : [UIFont systemFontOfSize:15];
    [button setTitle:(text ? text : @"") forState:UIControlStateNormal];
    [button setTitleColor:(textColor ? textColor : [UIColor blackColor]) forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Animation

- (void)ch_shakeView {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.repeatCount = 1;
    anim.values = @[@-4,@4,@-4,@4];
    [self.layer addAnimation:anim forKey:nil];
}

- (void)ch_shakeRotation:(CGFloat)rotation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.repeatCount = 2;
    anim.duration = .2;
    anim.values = @[@0,@(rotation),@0,@(-rotation),@0];
    [self.layer addAnimation:anim forKey:nil];
}

- (void)ch_scaling {
    [self.layer addAnimation:CHUIViewScalingAnimation() forKey:nil];
}

#pragma mark - Runtime

- (void)ch_tapActionHandler:(UIViewTapActionBlock)block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &Key_UIViewTapAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)ch_touchActionHandler:(void (^)(void))block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &Key_UIViewTapAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -

- (void)tapAction:(UITapGestureRecognizer *)tap {
    UIViewTapActionBlock blcok = objc_getAssociatedObject(self, &Key_UIViewTapAction);
    if (blcok) {
        blcok();
    }
}

@end
