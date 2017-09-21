//
//  replaceView.m
//  newEra
//
//  Created by lantian on 2017/7/13.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "replaceView.h"
#import <objc/runtime.h>

@implementation replaceView

+(void)load{
    
    
    //    //获取两个类的方法
    //    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    //    Method m2 = class_getClassMethod([UIImage class], @selector(ll_imageName:));
    
    //    //开始交换方法实现
    //    method_exchangeImplementations(m1, m2);
    //相比较于Runtime_ReplaceSystemMethod的中直接写的method_exchangeImplementations,即上边那种写法,下面的这种方法更加的严谨一些
    
    
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //要特别注意你替换的方法到底是个性质的方法
        // When swizzling a Instance method, use the following:
        //        Class class = [self class];
        
        // When swizzling a class method, use the following:
        Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(setAnimationsEnabled:);
        SEL swizzledSelector = @selector(setAnimationsEnabledNew:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}




+ (void)setAnimationsEnabledNew:(BOOL)enabled
{
    NSLog(@"ReplaceSystemFunc --- UIView setAnimationsEnabled");
    //    [UIView setAnimationsEnabled:enabled];
}

@end
