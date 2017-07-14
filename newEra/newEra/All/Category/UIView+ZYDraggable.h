//
//  UIView+ZYDraggable.h
// 产生一个可以拖拽的View
//
//  Created by 张志延 on 16/8/25. (https://github.com/zzyspace)
//  Copyright © 2016年 tongbu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Draggable)

/**
 *  Make view draggable.
 *
 *  @param view    Animator reference view, usually is super view.
 *  @param damping Value from 0.0 to 1.0. 0.0 is the least oscillation. default is 0.4.
 */
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;
- (void)makeDraggable;

/**
 *  Disable view draggable.
 */
- (void)removeDraggable;


/**
 *  让某一个视图抖动
 *
 */
- (void)viewToShake;



@end
