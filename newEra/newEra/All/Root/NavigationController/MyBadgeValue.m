//
//  MyBadgeValue.m
//  Registry
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技有限公司. All rights reserved.
//

#import "MyBadgeValue.h"

@implementation MyBadgeValue

+ (instancetype)shareMyBadgeValue
{
    static MyBadgeValue *myBadgeValue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myBadgeValue = [[MyBadgeValue alloc] init];
        myBadgeValue.backgroundColor = [UIColor redColor];
    });
    return myBadgeValue;
}

+ (void)hidden
{
    MyBadgeValue *myBadgeValue = [MyBadgeValue shareMyBadgeValue];
    myBadgeValue.hidden = YES;
}
+ (void)show
{
    MyBadgeValue *myBadgeValue = [MyBadgeValue shareMyBadgeValue];
    myBadgeValue.hidden = NO;
}


@end
