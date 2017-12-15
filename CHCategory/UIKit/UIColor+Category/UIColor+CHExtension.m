//
//  UIColor+CHExtension.m
//  BuyerShow
//
//  Created by Guowen Wang on 2017/2/28.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import "UIColor+CHExtension.h"

@implementation UIColor (CHExtension)

+ (UIColor *)ch_1A_Color {
    return [self colorWithHexString:@"#1A1A1A"];
}

+ (UIColor *)ch_3C_Color {
    return [self colorWithHexString:@"#3C3C3C"]; //rgb(81)
}

+ (UIColor *)ch_51_Color {
    return [self colorWithHexString:@"#515151"];
}

+ (UIColor *)ch_58_Color {
    return [self colorWithHexString:@"#585858"];
}

+ (UIColor *)ch_6C_Color {
    return [self colorWithHexString:@"#CCCCCC"]; //rgb(204)
}

+ (UIColor *)ch_6E_Color {
    return [self colorWithHexString:@"#EEEEEE"];
}

+ (UIColor *)ch_6F_Color {
    return [self colorWithHexString:@"#FFFFFF"];
}

+ (UIColor *)ch_80_Color {
    return [self colorWithHexString:@"#808080"];
}

+ (UIColor *)ch_9A_Color {
    return [self colorWithHexString:@"#9A9A9A"];
}

+ (UIColor *)ch_B1_Color {
    return [self colorWithHexString:@"#B1B1B1"];
}

+ (UIColor *)ch_B4_Color {
    return [self colorWithHexString:@"#B4B4B4"];
}

+ (UIColor *)ch_B5_Color {
    return [self colorWithHexString:@"#B5B5B5"];
}

+ (UIColor *)ch_B6_Color {
    return [self colorWithHexString:@"#B6B6B6"];
}

+ (UIColor *)ch_C8_Color {
    return [self colorWithHexString:@"#c8c8c8"];
}

+ (UIColor *)ch_E6_Color {
    return [self colorWithHexString:@"#E6E6E6"]; //rgb(238)
}

+ (UIColor *)ch_F4_Color {
    return [self colorWithHexString:@"#F4F4F4"]; //rgb(238)
}

+ (UIColor *)ch_F7F9FB {
    return [self colorWithHexString:@"#F7F9FB"];
}

+ (UIColor *)ch_FF4088 {
    return [self colorWithHexString:@"#FF4088"];
}

+ (UIColor *)ch_FF4881 {
    return [self colorWithHexString:@"#FF4881"];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] <= 6) {
        return [UIColor whiteColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return [UIColor whiteColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
