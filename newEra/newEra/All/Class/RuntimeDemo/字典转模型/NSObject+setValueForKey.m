//
//  NSObject+setValueForKey.m
//  newEra
//
//  Created by lantian on 2017/7/14.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+setValueForKey.h"

@implementation NSObject (setValueForKey)






/**
 复杂字典转模型基本原理简化版
 
 setValue ForKey
 ----------------------------------------
 1. 获取模型属性列表
 2. 判断是否有嵌套模型的属性
 3. 递归操作该属性
 -----------------------------------------
 */

//+ (id)objectWithKeyValues:(NSDictionary *)aDictionary {
//    id objc = [[self alloc] init];
//    for (NSString *key in aDictionary.allKeys) {
//        id value = aDictionary[key];
//        
//        /*判断当前属性是不是Model*/
//        objc_property_t property = class_getProperty(self, key.UTF8String);
//        unsigned int outCount = 0;
//        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount);
//        objc_property_attribute_t attribute = attributeList[0];
//        NSString *typeString = [NSString stringWithUTF8String:attribute.value];
//        // 此处应该有递归判断处理,处理模型中的模型,模型中的数组中的模型
//        if ([typeString isEqualToString:@"@\"setValueForKeyModel\""]) {
//            value = [self objectWithKeyValues:value];
//        }
//        /**********************/
//        
//        //生成setter方法，并用objc_msgSend调用
//        NSString *methodName = [NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString,[key substringFromIndex:1]];
//        SEL setter = sel_registerName(methodName.UTF8String);
//        if ([objc respondsToSelector:setter]) {
//            ((void (*) (id,SEL,id)) objc_msgSend) (objc,setter,value);
//        }
//        free(attributeList);
//    }
//    return objc;
//}

- (NSDictionary *)keyValuesWithObject{
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = propertyList[i];
        
        //生成getter方法，并用objc_msgSend调用
        const char *propertyName = property_getName(property);
        SEL getter = sel_registerName(propertyName);
        if ([self respondsToSelector:getter]) {
            id value = ((id (*) (id,SEL)) objc_msgSend) (self,getter);
            
            /*判断当前属性是不是Model*/
            if ([value isKindOfClass:[self class]] && value) {
                value = [value keyValuesWithObject];
            }
            /**********************/
            
            if (value) {
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dict setObject:value forKey:key];
            }
        }
        
    }
    free(propertyList);
    return dict;
}






- (void)setDict:(NSDictionary *)dict {
    
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 成员变量名转为属性名（去掉下划线 _ ）
            key = [key substringFromIndex:1];
            // 取出字典的值
            id value = dict[key];
            
            // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
            if (value == nil) continue;
            
            // 获得成员变量的类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            // 如果属性是对象类型
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                // 那么截取对象的名字（比如@"Dog"，截取为Dog）
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                // 排除系统的对象类型
                if (![type hasPrefix:@"NS"]) {
                    // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
                    Class class = NSClassFromString(type);
                    value = [class objectWithKeyValues:value];
                    
                }else if ([type isEqualToString:@"NSArray"]) {
                    
                    // 如果是数组类型，将数组中的每个模型进行字典转模型，先创建一个临时数组存放模型
                    NSArray *array = (NSArray *)value;
                    NSMutableArray *mArray = [NSMutableArray array];
                    
                    // 获取到每个模型的类型
                    id class ;
                    if ([self respondsToSelector:@selector(arrayObjectClass)]) {
                        
                        NSString *classStr = [self arrayObjectClass];
                        class = NSClassFromString(classStr);
                    }
                    // 将数组中的所有模型进行字典转模型
                    for (int i = 0; i < array.count; i++) {
                        [mArray addObject:[class objectWithKeyValues:value[i]]];
                    }
                    
                    value = mArray;
                }
            }
            
            // 将字典中的值设置到模型上
            [self setValue:value forKeyPath:key];
        }
        free(ivars);
        c = [c superclass];
    }
}

+ (instancetype )objectWithKeyValues:(NSDictionary *)aDictionary {
    NSObject *obj = [[self alloc]init];
    [obj setDict:aDictionary];
    return obj;
}






@end
