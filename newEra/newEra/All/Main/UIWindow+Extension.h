//
//  UIWindow+Extension.h
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Extension)




/**
 在外界通过setter 控制TabBarController跳转到第几个Item

 @param index 索引
 */
+ (void)selectedItemIndex:(int)index;




/**
 自动匹配设置试图控制器
 */
- (void)startUpRootController;


/**
 设置跟视图为默认根视图
 */
- (void)defaultRootController;



/**
 获取当前界面的viewController
 
 @return viewController
 */
+ (UIViewController *)getCurrentVC;






@end
