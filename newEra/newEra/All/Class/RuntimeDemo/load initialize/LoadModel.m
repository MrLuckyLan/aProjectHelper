//
//  LoadModel.m
//  newEra
//
//  Created by lantian on 2017/7/13.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "LoadModel.h"


@implementation LoadModel




+ (void)load
{
    NSLog(@"sub  load");
}


/*
 子类会调用父类的+(void)initialize 此方法不实现 LoadClassModel initialize 会执行两次
 */
//+ (void)initialize
//{
//    NSLog(@"sub  initialize");
//}



@end
