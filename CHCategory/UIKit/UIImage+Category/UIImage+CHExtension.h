//
//  UIImage+CHExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 2017/2/23.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
    渐变颜色图片的方向
 */
typedef NS_ENUM(NSInteger, GradualDirection) {
    GradualDirectionVertical     = 0,    /** 竖直 */
    GradualDirectionHorizontal   = 1,    /** 水平 */
};


@interface UIImage (CHInstance)

- (UIImage *)ch_imageWithColor:(UIColor *)color;

- (UIImage *)ch_resizedImageByWidth:(NSUInteger)width;
- (UIImage *)ch_resizedImageByHeight:(NSUInteger)height;
- (UIImage *)ch_resizedImageWithMinimumSize:(CGSize)size;
- (UIImage *)ch_resizedImageWithMaximumSize:(CGSize)size;
- (UIImage *)ch_resizedImageWithRect:(CGRect)rect;

@end


#pragma mark -


@interface UIImage (CHClass)

+ (UIImage *)ch_imageWith:(UIColor *)color;
+ (UIImage *)ch_imageWith:(UIColor *)color size:(CGSize)size;

/**
 返回二维码
 
 @param content 二维码内容字符串
 @return 二维码图片
 */
+ (UIImage *)ch_QRCodeImageWithContent:(NSString *)content;

/**
 生成颜色渐变的图片
 
 @param startColor 开始颜色
 @param endColor   结束颜色
 @param direction  渐变方向
 @param frame      图片大小
 @return 颜色渐变的图片
 */
+ (UIImage *)ch_gradualImageWith:(UIColor *)startColor :(UIColor *)endColor direction:(GradualDirection)direction frame:(CGRect)frame;

@end
