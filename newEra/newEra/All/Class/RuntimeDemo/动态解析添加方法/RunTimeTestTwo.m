//
//  RunTimeTestTwo.m
//  newEra
//
//  Created by lantian on 2017/7/13.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <objc/runtime.h>
#import "RunTimeTestTwo.h"
#import "RunTimeReplacer.h"

@implementation RunTimeTestTwo




- (void)jump
{
    NSLog(@"i cann't fly , but i can jump jump jump");
}





/*****************************  调用了不存在的方法 决议过程 第 1 次机会  *****************************/


/**
 如果当前对象调用了一个不存在的方法
 Runtime会调用resolveInstanceMethod:来进行动态方法解析

 @param sel 发送的消息"fly"是一个不存在的方法
 @return 返回NO，则进入下一步forwardingTargetForSelector:
 
 注意: 是为对象方法进行决议,而resolveClassMethod是为类方法进行决议
 
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    /*
     type0: 第一决议不处理 进入下一步forwardingTargetForSelector
     type1: 直接处理并且替换 到 jump 方法
     */
    int type = 0;
    if (0 == type)
    {
        return NO;
    }
    else
    {
        class_addMethod(self, sel, class_getMethodImplementation(self, sel_registerName("jump")), "v@:");
        return [super resolveInstanceMethod:sel];
    }
}



/*****************************  第 2 次机会  *****************************/

/**
 通过重载方法 来替换消息的 "接受者" 为 "其他对象"

 @param aSelector 不存在的方法
 @return 返回nil则进步下一步forwardInvocation:
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    /*
     type0: 第 2 次机会不处理 进入下一步forwardInvocation
     type1: 重新分析消息接收者 替换到 RunTimeReplacer 中寻找fly方法
     */
    int type = 0;
    if (0 == type)
    {
        return nil;
    }
    else
    {
        return [RunTimeReplacer new];
    }
}

/*****************************  第 2.5 次机会  *****************************/

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    /*
     获取方法签名进入下一步，进行消息转发
     
     v：返回值类型 i = int，v = void
     @：参数id(self)
     : SEL(_cmd)
     
     */
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    /*
     消息转发
     */
    return [anInvocation invokeWithTarget:[[RunTimeReplacer alloc] init]];
//    ??????????  [anInvocation invokeWithTarget:[[RunTimeReplacer alloc] init]];
}







@end
