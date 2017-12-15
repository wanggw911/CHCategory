//
//  NSDate+GWExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 15/11/14.
//  Copyright © 2015年 Guowen Wang. All rights reserved.
//

#import "NSDate+CHExtension.h"
#import "NSDate-Utilities.h"

static NSDateFormatter *sharedDateFormatterInstance = nil;


@implementation NSDate (CHInstance)

- (NSDateFormatter *)sharedDateFormatter {
    if(!sharedDateFormatterInstance){
        sharedDateFormatterInstance = [[NSDateFormatter alloc] init];
    }
    
    return sharedDateFormatterInstance;
}

- (NSString *)ch_stringWithCommonDateFormat:(NSString *)dateFormat {
    if(dateFormat == nil) {
        return self.description;
    }
    else {
        NSDateFormatter *formatter = [self sharedDateFormatter];
        formatter.dateFormat = dateFormat;
        return [formatter stringFromDate:self];;
    }
}

- (NSString *)ch_stringWithCustomizedDateFormat:(NSString *)timestamp {
    NSString *customizedTimeString = nil;
    
    NSTimeInterval dataIn = timestamp.doubleValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dataIn];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"HH:mm"];
    
    if (date.isToday) {//今天
        customizedTimeString = [fmt stringFromDate:date];
    }
    else if (date.isYesterday) {
        //昨天
        if (date.deltaWithNow.hour < 24){
            fmt.dateFormat = [NSString stringWithFormat:@"%ld小时前", (long)date.deltaWithNow.hour];
        }
        else {
            fmt.dateFormat = @"MM-dd";
        }
        customizedTimeString = [fmt stringFromDate:date];
    }
    else if (date.isThisYear) {
        //今年(至少是前天)
        fmt.dateFormat = @"MM-dd";
        customizedTimeString = [fmt stringFromDate:date];
    }
    else {
        //非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        customizedTimeString = [fmt stringFromDate:date];
    }
    
    return customizedTimeString;
}

- (NSDateComponents *)deltaWithNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end


#pragma mark -


@implementation NSDate (CHClass)

+ (NSString *)ch_stringOfTimestamp {
    NSString *timestamp = [NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]];
    return timestamp;
}

+ (NSString *)ch_stringOfTimeWithTimestamp:(NSString *)timestamp DateFormat:(NSString *)dateFormat {
    NSString *timeSting = nil;
    
    //计算时间只能按前十位的时间戳字符串来计算
    if (timestamp.length > 10) {
        timestamp = [timestamp substringToIndex:10];
    }
    
    NSTimeInterval dataIn = timestamp.doubleValue;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataIn];
    
    NSDateFormatter *dateFormatter = [[NSDate date] sharedDateFormatter];
    [dateFormatter setDateFormat:dateFormat];
    timeSting = [dateFormatter stringFromDate:confromTimesp];
    
    return timeSting;
}

+ (NSDateComponents *)ch_timeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    unsigned int unitFlag;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    unitFlag =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
    | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
#else
    unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
    | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
#endif
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *interval = [cal components:unitFlag fromDate:fromDate toDate:toDate options:0];
    
    return interval;
}

@end






