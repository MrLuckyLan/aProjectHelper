//
//  LtTabBarView
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LtTabBarView;

@protocol LtTabBarViewDelegate <NSObject>

- (void)tabBar:(LtTabBarView *)tabBar didSelectItemFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface LtTabBarView : UIView




@property (nonatomic, weak) id<LtTabBarViewDelegate>delegate;


- (void)addTabBarButtonWithName:(NSString *)name selName:(NSString *)selName;

/**单例*/
+ (instancetype)shareTabBar;
/**TabBar显示*/
+ (void)show;
/**TabBar隐藏*/
+ (void)hidden;


/**动画*/
- (void)buttonClick:(UIButton *)button;




@end
