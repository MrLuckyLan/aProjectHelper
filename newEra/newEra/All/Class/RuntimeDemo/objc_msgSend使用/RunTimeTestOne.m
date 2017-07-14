//
//  RunTimeTestOne.m
//  newEra
//
//  Created by lantian on 2017/7/13.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "RunTimeTestOne.h"

@implementation RunTimeTestOne





-(void)noReturnNoParameter{
    NSLog(@"无参数无返回");
}
-(void)noReturnHaveParameter:(NSString *)p{
    NSLog(@"有参数%@无返回", p);
}

- (NSString *)haveReturnHaveParameter:(NSString *)p{
    NSLog(@"有参数有返回");
    return p;
}










@end
