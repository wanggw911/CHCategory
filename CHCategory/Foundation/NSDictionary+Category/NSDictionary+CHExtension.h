//
//  NSDictionary+CHExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 2017/2/23.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Instance 方法
@interface NSDictionary (CHInstance)

//安全获取值
- (id)ch_objectForKey:(id)key;
- (BOOL)ch_boolForKey:(id)key;
- (NSInteger)ch_integerForKey:(id)key;
- (long long)ch_longlongForKey:(id)key;
- (NSNumber *)ch_numberForKey:(id)key;
- (NSString *)ch_stringForKey:(id)key;
- (NSArray *)ch_arrayForKey:(id)key;
- (NSDictionary *)ch_dictionaryForKey:(id)key;

@end

#pragma mark - Class 方法
@interface NSDictionary (CHClass)
+ (id)ch_dictionaryWithObject:(id)object forKey:(id<NSCopying>)key;
@end



#pragma mark - Instance 方法
@interface NSMutableDictionary (CHInstance)
- (void)ch_setObject:(id)anObject forKey:(id<NSCopying>)key;
@end
