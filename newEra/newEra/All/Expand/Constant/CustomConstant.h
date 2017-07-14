//
//  CustomConstant.h
//  newEra
//
//  Created by lantian on 2017/7/11.
//  Copyright © 2017年 LT. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  传入设计师提供的宽度获得适配屏幕的真实宽度（我们设计师提供的图片的标准是iPhone 6(@2x) : 750 x 1334）
 *
 *  @param designWidth 设计师提供的宽度
 *
 *  @return 适配屏幕的真实宽度
 */
static inline CGFloat UIWidth(CGFloat designWidth)
{
    return  (designWidth / 750.0) * ([UIScreen mainScreen].bounds.size.width);
}

/**
 *  传入设计师提供的高度获得适配屏幕的真实高度（我们设计师提供的图片的标准是iPhone 6(@2x) : 750 x 1334）
 *
 *  @param designHeight 设计师提供的高度
 *
 *  @return 适配屏幕的真实高度
 */
static inline CGFloat UIHeight(CGFloat designHeight)
{
    return  (designHeight / 1334.0) * ([UIScreen mainScreen].bounds.size.height);
}




#pragma mark - ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::   通知   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

extern NSString * const NotificationNameForAppDelegateBackOff;


















