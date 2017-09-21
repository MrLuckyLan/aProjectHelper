//
//  LtTabBarBtn
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef enum BadgeStyle
{
    /**自己的界面*/
    Normal_BadgeStyle = 0,
    /**别人的界面*/
    Number_BadgeStyle,
    
}badgeStyle;


@interface LtTabBarBtn : UIButton


- (void)badgeStyle:(badgeStyle)style;

- (void)badgeNormalShow:(BOOL)show;

- (void)badgeNum:(int)num;



@end
