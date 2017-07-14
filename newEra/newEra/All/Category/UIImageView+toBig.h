//
//  UIImageView+toBig.h
//  测试UI
//
//  Created by 夏东健 on 2017/3/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToBigImageViewDelegate <NSObject>

@optional
- (void)PressBtn;

@end

@interface UIImageView (toBig)

@property (nonatomic ,weak)id<ToBigImageViewDelegate> toBigImageVdelegate;

/**
 使该 UIImageView 控件具有点击放大并将图片保存到相册的效果
 */
- (void)canToBigImageViewWithWindow;


@end
