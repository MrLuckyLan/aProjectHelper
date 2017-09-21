//
//  UIImage+replaceSystem.m
//  newEra
//
//  Created by lantian on 2017/7/13.
//  Copyright © 2017年 LT. All rights reserved.
//


#import <objc/runtime.h>
#import "UIImage+replaceSystem.h"

@implementation UIImage (replaceSystem)






//+(void)load{
//    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
//    Method m2 = class_getClassMethod([UIImage class], @selector(ll_imageName:));
//    method_exchangeImplementations(m1, m2);
//}
//
//+ (UIImage *)ll_imageName:(NSString *)imageName{
//    double version = [[UIDevice currentDevice].systemVersion doubleValue];
//    NSLog(@"%f",version);
//    if (version <= 8.0) {
//        // 如果系统版本是7.0以上，使用另外一套文件名结尾是‘_os7’的扁平化图片
//        imageName = [imageName stringByAppendingString:@"_ios7"];
//    }
//    
//    return [UIImage ll_imageName:imageName];
//}









@end
