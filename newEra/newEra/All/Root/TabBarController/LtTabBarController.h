//
//  LtTabBarController
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LtTabBarController : UITabBarController




/**
 在外界通过setter 控制tabBar跳转到第几个Item
 */
@property (nonatomic,assign) int privateSelectedIndex;


/**
 清空所有badge
 */
- (void)cleanAllBadge;


/**
 控制tabbarItem 通知显示隐藏数目等
 
 @param index 第几个Item
 @param show (仅控制)圆点Style 显示隐藏
 @param num  (紧控制)数字Style 传入0则默认隐藏
 */
- (void)ItemAtIndex:(int)index BadgeShow:(BOOL)show BadgeValue:(int)num;



@end
