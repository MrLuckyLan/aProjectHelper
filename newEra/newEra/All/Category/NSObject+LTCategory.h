//
//  NSObject+LTCategory.h
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LTCategory)



/*
 nil、Nil、NULL、NSNull的区别
 nil：指向一个对象的空指针
 Nil：指向一个类的空指针
 NULL：指向其他类型（如：基本类型、C类型）的空指针
 NSNull：通常表示集合中的空值
 */
- (BOOL)isExist;




// 把对象转换成JSON格式数据，如果转换失败，返回nil
+ (NSMutableData *)JSONDataWithObject:(id)object;

//! 保存应用在AppStore上版本到本地
+ (void)saveAppStoreVersionToUserDefaults;

//! 是否需要连网更新
+ (BOOL)isAppNeedToUpdate:(BOOL)needNetwork;

// 参数是要判断的应用的URLSchemes
+ (BOOL)hadInstallApp:(NSString *)urlSchemes;
// 能否打开应用
+ (BOOL)canOpenApp:(NSString *)itunesUrlString;
// 打开自己开发的应用
+ (void)openApp:(NSString *)urlSchemes;
//! 进入AppStore
+ (void)goToAppStoreWithURLString:(NSString *)itunesUrlString;











@end
