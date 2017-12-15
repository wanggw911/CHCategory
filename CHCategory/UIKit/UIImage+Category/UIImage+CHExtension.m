//
//  UIImage+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 2017/2/23.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import "UIImage+CHExtension.h"

@implementation UIImage (CHInstance)

- (UIImage *)ch_imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ch_resizedImageByWidth:(NSUInteger)width {
    if (self.size.width < width) {
        return self;
    }
    CGImageRef imgRef = [self CGImageWithCorrectOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat ratio = width/original_width;
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, width, round(original_height * ratio))];
}

- (UIImage *)ch_resizedImageByHeight:(NSUInteger)height {
    CGImageRef imgRef = [self CGImageWithCorrectOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat ratio = height/original_height;
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * ratio), height)];
}

- (UIImage *)ch_resizedImageWithMinimumSize:(CGSize)size {
    CGImageRef imgRef = [self CGImageWithCorrectOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat width_ratio = size.width / original_width;
    CGFloat height_ratio = size.height / original_height;
    CGFloat scale_ratio = MAX(width_ratio, height_ratio);
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * scale_ratio), round(original_height * scale_ratio))];
}

- (UIImage *)ch_resizedImageWithMaximumSize:(CGSize)size {
    CGImageRef imgRef = [self CGImageWithCorrectOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat width_ratio = size.width / original_width;
    CGFloat height_ratio = size.height / original_height;
    CGFloat scale_ratio = MIN(width_ratio, height_ratio);
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * scale_ratio), round(original_height * scale_ratio))];
}

- (UIImage *)ch_resizedImageWithRect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

#pragma mark -

- (CGImageRef)CGImageWithCorrectOrientation {
    if (self.imageOrientation == UIImageOrientationDown) {
        //retaining because caller expects to own the reference
        return CGImageRetain([self CGImage]);
    }
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, 90 * M_PI/180);
    }
    else if (self.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, -90 * M_PI/180);
    }
    else if (self.imageOrientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, 180 * M_PI/180);
    }
    
    [self drawAtPoint:CGPointMake(0, 0)];
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    
    return newCGImage;
}

- (UIImage *)drawImageInBounds:(CGRect)bounds {
    UIGraphicsBeginImageContext(bounds.size);
    [self drawInRect: bounds];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

@end


#pragma mark -


@implementation UIImage (CHClass)

+ (UIImage *)ch_imageWith:(UIColor *)color {
    return [self ch_imageWith:color size:CGSizeMake(10, 10)];
}

+ (UIImage *)ch_imageWith:(UIColor *)color size:(CGSize)size {
    NSParameterAssert(color);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)ch_QRCodeImageWithContent:(NSString *)content {
    NSParameterAssert(content);
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1.
                                   orientation:UIImageOrientationUp];
    CGImageRelease(cgImage);
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat rate = screenWidth / MAX(image.size.width, image.size.height);
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}

+ (UIImage *)ch_gradualImageWith:(UIColor *)startColor :(UIColor *)endColor direction:(GradualDirection)direction frame:(CGRect)frame {
    NSArray *colors = @[startColor, endColor];
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    
    //(0.0, 0.0) (1.0, 0.0)代表水平方向渐变
    //(0.0, 0.0) (0.0, 1.0)代表竖直方向渐变
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = direction == GradualDirectionHorizontal ? CGPointMake(frame.size.width, 0.0) : CGPointMake(0.0, frame.size.width);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return image;
}

@end
