//
//  MyBadgeValue.h
//  Registry
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/**更新提醒_红点点*/
@interface MyBadgeValue : UIView

/**单例*/
+ (instancetype)shareMyBadgeValue;
/**红点点显示*/
+ (void)show;
/**红点点隐藏*/
+ (void)hidden;


@end
