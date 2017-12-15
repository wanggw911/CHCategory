//
//  NSDate+GWExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 15/11/14.
//  Copyright © 2015年 Guowen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CHInstance)

/** 将日期按指定的格式转为字符串 如返回：yyyy-MM-dd HH.mm.ss */
- (NSString *)ch_stringWithCommonDateFormat:(NSString *)dateFormat;

/** 把时间戳转化成定制格式的时间字符串 */
- (NSString *)ch_stringWithCustomizedDateFormat:(NSString *)timestamp;

@end


#pragma mark -


@interface NSDate (CHClass)

/** 获取时间戳的字符串 */
+ (NSString *)ch_stringOfTimestamp;

/** 把时间戳转化成指定的格式的时间字符串 */
+ (NSString *)ch_stringOfTimeWithTimestamp:(NSString *)timestamp DateFormat:(NSString *)dateFormat;

/** 两个时间之间的差值，返回值：[gap year] [gap month] [gap day] [gap hour] [gap minute] [gap second]  */
+ (NSDateComponents *)ch_timeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end






