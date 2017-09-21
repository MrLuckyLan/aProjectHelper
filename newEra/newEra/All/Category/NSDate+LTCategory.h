//
//  NSDate+LTCategory.h
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTCategory)

- (BOOL)isToday;

- (BOOL)isYesterday;

- (BOOL)isTomorrow;

- (BOOL)isThisYear;

- (BOOL)isThisMonth;

/**
 NSDate 转成 13位NSString

 @return 13位@"1111111111111"
 */
- (NSString *)timestampNSString13;

/**
 NSDate 转成 13位long long

 @return 13位long long 123456789000
 */
- (long long )timestamplong13;

/**
 13位字符串时间戳转成yyyy-MM-dd HH:mm:ss

 @param dateStr 13位字符串
 @return yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)timestampNSDate13withDateStr:(NSString *)dateStr;


/**
 NSDate 转成 yyyy-MM-dd HH:mm:ss

 @return yyyy-MM-dd HH:mm:ss
 */
- (NSString*)dateToString;

/**
 yyyy-MM-dd HH:mm:ss 转成NSDate

 @param dateString yyyy-MM-dd HH:mm:ss
 @return NSDate
 */
+(NSDate*)stringToDate:(NSString*)dateString;



/**
 距离现在多久

 @param compareDate 需比较的时间(13位时间戳)
 @return 时间差 几天前,几个月前
 */
+ (NSString *)compareCurrentTime:(NSTimeInterval) compareDate;


/**
 通过时间戳和格式显示时间

 @param timestamp long long 13位时间戳
 @param formatter 格式  (yyyy-MM-dd HH:mm:ss 等)
 @return 时间字符串
 */
+ (NSString *)getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter;

















@end
