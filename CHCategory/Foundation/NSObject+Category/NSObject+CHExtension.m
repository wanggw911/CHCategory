//
//  NSObject+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 15/11/10.
//  Copyright © 2015年 Guowen Wang. All rights reserved.
//

#import "NSObject+CHExtension.h"

@implementation NSObject (CHInstance)

- (BOOL)ch_isEmpty {
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        return [[(NSString *)self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] <= 0;
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        return [(NSArray *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSSet class]]) {
        return [(NSSet *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSData class]]) {
        return [(NSData *)self length] <= 0;
    }
    
    return NO;
}

@end
