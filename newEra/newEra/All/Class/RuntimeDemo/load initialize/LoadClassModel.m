//
//  LoadClassModel.m
//  newEra
//
//  Created by lantian on 2017/7/13.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "LoadClassModel.h"

@implementation LoadClassModel





+ (void)load
{
    NSLog(@"super  load");
}


/*
    即使子类LoadModel 不执行实现initialize 也会被调用 会导致被调用两次
 */
+ (void)initialize
{
    NSLog(@"super  initialize");
    /**
     正确的姿势
     */
    //    if (self == [LoadClassModel class]) {
    //        NSLog(@"super  initialize");
    //    }
    
}










@end
