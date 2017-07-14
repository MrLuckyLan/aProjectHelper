//
//  UIButton+LTTimer.m
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "UIButton+LTTimer.h"
#import <objc/runtime.h>





#define kVerifyMsgTake @"获取验证码"
#define kVerifyMsgDidToke @"验证码已发送"
#define kVerifyMsgLoad @"秒后重新获取"

static const char * verifyStartBlockKey = "verifyStartBlockKey";
static const char * verifyCompleteBlockKey = "verifyCompleteBlockKey";
static const char * verifyTimerKey = "verifyTimerKey";
static const char * verifyIntervalKey = "verifyIntervalKey";
static const char * verifyCountDownKey = "verifyCountDownKey";



@implementation UIButton (LTTimer)




#pragma mark -
- (void)addTimerForVerifyWithInterval:(NSUInteger)interval start:(BtnTimerStartBlock)startBlock complete:(BtnTimerCompleteBlock)completeBlock {
    
    [self setTitle:kVerifyMsgTake forState:UIControlStateNormal];
    
    [self addTarget:self action:@selector(verifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (startBlock) {
        objc_setAssociatedObject(self, verifyStartBlockKey, startBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    if (completeBlock) {
        objc_setAssociatedObject(self, verifyCompleteBlockKey, completeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    objc_setAssociatedObject(self, verifyIntervalKey, @(interval), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, verifyCountDownKey, @(interval), OBJC_ASSOCIATION_ASSIGN);
}

- (void)verifyButtonClick:(UIButton *)button {
    if (!button.enabled) return;
    
    void(^startBlock)(void) = objc_getAssociatedObject(self, verifyStartBlockKey);
    if (startBlock) {
        startBlock();
    }
    
    button.enabled = NO;
    [button setTitle:kVerifyMsgDidToke forState:UIControlStateDisabled];
    
    [self startTimer];
}

- (void)startTimer {
    NSTimer * timer = objc_getAssociatedObject(self, verifyTimerKey);
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(minusVerifyTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        objc_setAssociatedObject(self, verifyTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)stopTimer {
    NSTimer * timer = objc_getAssociatedObject(self, verifyTimerKey);
    if (timer) {
        [timer invalidate];
        timer = nil;
        objc_setAssociatedObject(self, verifyTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)minusVerifyTime {
    int verifyTime = [objc_getAssociatedObject(self, verifyCountDownKey) intValue];
    if (verifyTime == 0) {
        self.enabled = YES;
        [self stopTimer];
        objc_setAssociatedObject(self, verifyCountDownKey, objc_getAssociatedObject(self, verifyIntervalKey), OBJC_ASSOCIATION_ASSIGN);
        
        void(^completeBlock)(void) = objc_getAssociatedObject(self, verifyCompleteBlockKey);
        if (completeBlock) {
            completeBlock();
        }
        return;
    }
    
    [self setTitle:[NSString stringWithFormat:@"%d%@", verifyTime, kVerifyMsgLoad] forState:UIControlStateDisabled];
    verifyTime--;
    objc_setAssociatedObject(self, verifyCountDownKey, @(verifyTime), OBJC_ASSOCIATION_ASSIGN);
}



@end
