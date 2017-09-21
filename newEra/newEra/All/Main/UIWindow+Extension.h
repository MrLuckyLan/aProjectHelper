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
 控制tabbarItem 通知显示隐藏数目等

 @param index 第几个Item
 @param show (仅控制)圆点Style 显示隐藏
 @param num  (紧控制)数字Style 传入0则默认隐藏
 */
+ (void)ItemAtIndex:(int)index BadgeShow:(BOOL)show BadgeValue:(int)num;



/**
 自动匹配设置试图控制器
 */
//- (void)startUpRootController; //待修改


/**
 设置跟视图为默认根视图
 */
//- (void)defaultRootController; // 待修改



/**
 获取当前界面的viewController
 
 @return viewController
 */
+ (UIViewController *)getCurrentVC;






@end
