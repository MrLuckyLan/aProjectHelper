//
//  UIView+LTCategory.h
//  newEra
//
//  Created by lantian on 2017/7/7.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LTCategory)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat bottom;



/**
 圆角

 @param corners 上下左右
 @param size 大小
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size;

//当前view所在控制器
- (UIViewController*)viewController;




@end
