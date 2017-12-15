//
//  NSArray+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 15/11/15.
//  Copyright © 2015年 Guowen Wang. All rights reserved.
//

#import "NSArray+CHExtension.h"

@implementation NSArray (CHInstance)

- (id)ch_objectAtIndex:(NSInteger)index {
    if (index >= self.count) {
        return nil;
    }
    else{
        return [self objectAtIndex:index];
    }
}

@end
