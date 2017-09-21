//
//  NSDate+LTCategory.m
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "NSDate+LTCategory.h"

@implementation NSDate (LTCategory)

- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [dateformatter stringFromDate:self];
    NSString *nowString = [dateformatter stringFromDate:now];
    
    return [dateString isEqualToString:nowString];
}

- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [dateFormatter stringFromDate:self];
    NSString *nowString = [dateFormatter stringFromDate:now];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    now = [dateFormatter dateFromString:nowString];
    
    
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *dateComponents = [canlendar components:unit fromDate:date toDate:now options:0];
    
    return dateComponents.year == 0 && dateComponents.month == 0 && dateComponents.day == 1;
    
}

- (BOOL)isTomorrow
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [dateFormatter stringFromDate:self];
    NSString *nowString = [dateFormatter stringFromDate:now];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    now = [dateFormatter dateFromString:nowString];
    
    
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *dateComponents = [canlendar components:unit fromDate:date toDate:now options:0];
    
    return dateComponents.year == 0 && dateComponents.month == 0 && dateComponents.day == -1;
    
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents =[calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return dateComponents.year == nowComponents.year;
}

- (BOOL)isThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents =[calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
    
    return (dateComponents.year == nowComponents.year) && (dateComponents.month == nowComponents.month);
}

//时间转时间戳13位字符串123456789000
- (NSString *)timestampNSString13
{
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)[self timeIntervalSince1970] * 1000];
    return timeSp;
}
//时间转时间戳13位long long
- (long long )timestamplong13
{
    NSTimeInterval a = [self timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return [timeString  longLongValue];
}
//13位时间戳 转成 yyyy-MM-dd HH:mm:ss
+ (NSString *)timestampNSDate13withDateStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStr longLongValue] / 1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (NSString*)dateToString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [dateFormatter stringFromDate:self];
}
+(NSDate*)stringToDate:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    return [dateFormatter dateFromString:dateString];
}



+(NSString *)compareCurrentTime:(NSTimeInterval) compareDate
{
    
    NSDate *confromTimesp        = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
    
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    //    NSInteger referenceYear  =referenceComponents.year;
    //    NSInteger referenceMonth =referenceComponents.month;
    //    NSInteger referenceDay   =referenceComponents.day;
    NSInteger referenceHour  =referenceComponents.hour;
    //    NSInteger referemceMinute=referenceComponents.minute;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
    }
    
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}


+ (NSString*)getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter
{
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}






@end
