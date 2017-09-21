//
//  UIButton+LTTimer.h
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnTimerStartBlock)(void);
typedef void(^BtnTimerCompleteBlock)(void);

@interface UIButton (LTTimer)






/**
 添加一个倒数的计时器

 @param interval 定时总时间
 @param startBlock 开始计时器
 @param completeBlock 计时结束回调(可设置Button状态)
 */
- (void)addTimerForVerifyWithInterval:(NSUInteger)interval start:(BtnTimerStartBlock)startBlock complete:(BtnTimerCompleteBlock)completeBlock;





@end
