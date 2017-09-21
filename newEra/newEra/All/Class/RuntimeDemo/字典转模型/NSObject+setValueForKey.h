//
//  NSObject+setValueForKey.h
//  newEra
//
//  Created by lantian on 2017/7/14.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (setValueForKey)




/**
 字典转模型
 
 @param aDictionary 字典
 @return 模型
 */
+ (instancetype )objectWithKeyValues:(NSDictionary *)aDictionary;


/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)keyValuesWithObject;



/**
 告诉数组中都是什么类型的模型对象

 @return 可看setValueForKeyModel.m中的举例
 */
- (NSString *)arrayObjectClass ;


/**
 获取属性列表,匹配NSDictionary中的key

 @param dict 字典(json)
 */
- (void)setDict:(NSDictionary *)dict;






@end
