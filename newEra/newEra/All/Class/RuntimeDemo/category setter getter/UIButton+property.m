//
//  UIButton+property.m
//  newEra
//
//  Created by lantian on 2017/7/14.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "UIButton+property.h"
#import <objc/runtime.h>


static const void *associatedKey = "associatedKey";

@implementation UIButton (property)


- (void)setTouch:(UIButtonProperty)touch
{
    /*
    参数 object：给哪个对象设置属性
    参数 key：一个属性对应一个Key，将来可以通过key取出这个存储的值，key 可以是任何类型：double、int 等，建议用char 可以节省字节
    参数 value：给属性设置的值
    参数policy：存储策略 （assign 、copy 、 retain就是strong）
    objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
    */
    
    objc_setAssociatedObject(self, associatedKey, touch, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    if (touch) {
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIButtonProperty)touch
{
    return objc_getAssociatedObject(self, associatedKey);
}

- (void)buttonClick
{
    if (self.touch) {
        self.touch();
    }
}













@end
