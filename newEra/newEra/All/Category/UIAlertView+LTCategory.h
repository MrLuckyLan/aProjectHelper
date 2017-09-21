//
//  UIAlertView+LTCategory.h
//  newEra
//
//  Created by lantian on 2017/7/12.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (LTCategory)






/**
 自定义alertView
 
 @param title 标题
 @param messgae 内容
 @param cancelTitle 取消按钮标题
 @param confirmTitle 确定按钮标题
 @param cancel 取消回调
 @param confirm 确定回调
 @return new
 */
+ (instancetype)alertWithTitle:(NSString *)title messgae:(NSString *)messgae cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void(^)())cancel confirm:(void(^)())confirm;



+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message;





@end
