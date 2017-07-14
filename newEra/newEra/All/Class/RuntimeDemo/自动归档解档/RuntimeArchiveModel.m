//
//  RuntimeArchiveModel.m
//  newEra
//
//  Created by lantian on 2017/7/14.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "RuntimeArchiveModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RuntimeArchiveModel




- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount = 0;
    Ivar *vars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        
        // 注意kvc的特性是，如果能找到key这个属性的setter方法，则调用setter方法
        // 如果找不到setter方法，则查找成员变量key或者成员变量_key，并且为其赋值
        // 所以这里不需要再另外处理成员变量名称的“_”前缀
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(vars);
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int outCount = 0;
        Ivar *vars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(vars);
    }
    return self;
}









@end
