//
//  NSDate+CH.m
//  SixNews
//
//  Created by mac on 15/11/30.
//  Copyright (c) 2015年 张声扬. All rights reserved.
//

#import "NSDate+CH.h"

@implementation NSDate (CH)
-(BOOL)isToday
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitDay |NSCalendarUnitMonth|NSCalendarUnitYear;
    //获得当前时间的年月日
    NSDateComponents *nowCmps=[calendar components:unit fromDate:[NSDate date]];
    
    //获得 self 的年月日
    NSDateComponents  *selfCmps=[calendar components:unit fromDate:[NSDate date]];
    
    return
    (selfCmps.year==nowCmps.year)&&(selfCmps.month==nowCmps.month)&&(selfCmps.date==nowCmps.date);
    
}

-(BOOL)isYesterday
{
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    NSDate *selfDate = [self dateWithYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
    
}

-(BOOL)isThisYear
{
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitYear;
    //获得当前时间的年月日
    NSDateComponents *nowCmps=[calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year;
}

-(NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
//返回日期yyyy-MM-dd的格式的日期
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}
@end
