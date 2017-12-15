//
//  NSDictionary+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 2017/2/23.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import "NSDictionary+CHExtension.h"

#pragma mark - Instance 方法
@implementation NSDictionary (CHInstance)

- (id)ch_objectForKey:(id)key {
    if (!key) {
        NSLog(@"NSDictionary ch_objectForKey use nil key,dictionary=%@",self);
        return nil;
    }
    return [self objectForKey:key];
}

- (BOOL)ch_boolForKey:(id)key {
    NSString *value = [self ch_objectForKey:key];
    if (value && [value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return false;
}

- (NSInteger)ch_integerForKey:(id)key {
    NSString *value = [self ch_objectForKey:key];
    if (value && [value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return 0;
}

- (long long)ch_longlongForKey:(id)key {
    NSString *value = [self ch_objectForKey:key];
    if (value && [value respondsToSelector:@selector(longLongValue)]) {
        return [value longLongValue];
    }
    return 0;
}

- (NSNumber *)ch_numberForKey:(id)key {
    NSNumber *value = [self ch_objectForKey:key];
    if (value && ![value isKindOfClass:[NSNull class]]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            return value;
        }
        else if ([value respondsToSelector:@selector(doubleValue)]) {
            return [NSNumber numberWithDouble:[value doubleValue]];
        }
        return nil;
    }
    return nil;
}

- (NSString *)ch_stringForKey:(id)key {
    NSString *value = [self ch_objectForKey:key];
    if (value && ![value isKindOfClass:[NSNull class]]) {
        if ([value isKindOfClass:[NSString class]]) {
            return value;
        } else if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@", value];
        }
        return nil;
    }
    return nil;
}

- (NSArray *)ch_arrayForKey:(id)key {
    NSArray *value = [self ch_objectForKey:key];
    if (value && [value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)ch_dictionaryForKey:(id)key {
    NSDictionary *value = [self ch_objectForKey:key];
    if (value && [value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

@end



#pragma mark - Class 方法
@implementation NSDictionary (CHClass)

+ (id)ch_dictionaryWithObject:(id)object forKey:(id<NSCopying>)key {
    if (!key || !object) {
        NSLog(@"NSDictionary dictionaryWithObjectSafe set nil value or key,value=%@,key=%@", object, key);
        return nil;
    }
    return [self dictionaryWithObject:object forKey:key];
}

@end



#pragma mark - Instance 方法
@implementation NSMutableDictionary (CHInstance)

- (void)ch_setObject:(id)anObject forKey:(id<NSCopying>)key {
    if (!key || !anObject) {
        NSLog(@"NSMutableDictionary ch_setObject： set nil value or key,value=%@,key=%@,dictionary=%@", anObject, key, self);
        return;
    }
    return [self setObject:anObject forKey:key];
}

@end
