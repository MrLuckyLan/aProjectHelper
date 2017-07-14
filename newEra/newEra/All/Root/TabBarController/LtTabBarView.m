//
//  LtTabBarView
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技. All rights reserved.
//

#import "LtTabBarView.h"
#import "LtTabBarBtn.h"

#define TAG 600



/**屏幕宽*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
/**屏幕高*/
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LtTabBarView()

@property (nonatomic, weak) UIButton *selectButton;

@property (nonatomic, strong) UIButton *publicButton;



@end

@implementation LtTabBarView

+ (instancetype)shareTabBar
{
    static LtTabBarView *tabbar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbar = [[LtTabBarView alloc] init];
    });
    return tabbar;
}

+ (void)hidden
{
    LtTabBarView *tabar = [LtTabBarView shareTabBar];
    tabar.hidden = YES;
}
+ (void)show
{
    LtTabBarView *tabar = [LtTabBarView shareTabBar];
    tabar.hidden = NO;
}


- (void)addTabBarButtonWithName:(NSString *)name selName:(NSString *)selName
{
    self.userInteractionEnabled = YES;
    LtTabBarBtn *button = [LtTabBarBtn buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:name]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:selName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 默认选中界面
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
    
}

- (void)buttonClick:(UIButton *)button
{
    // 判断TabBarController 是否有某种方法 respondsToselector:(SEL)
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemFrom:to:)]) {
        [self.delegate tabBar:self didSelectItemFrom:(self.selectButton.tag - TAG) to:(button.tag - TAG)];
    }
    // 点击中间按钮的时候隔离
    if ((2 + TAG) == button.tag) {
        
    }
    else
    {
        // 当前按钮取消选中
        self.selectButton.selected = NO;
        // 新点击的按钮选中
        button.selected = YES;
        // 新点击的按钮成为"当前选中的按钮"
        self.selectButton = button;
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    for (int i = 0 ; i < count ; i++) {
        LtTabBarBtn *button = self.subviews[i];
        button.tag =TAG + i;
        // 设置frame
        CGFloat buttonY = 5;
        CGFloat buttonW = self.frame.size.width / count;
        CGFloat buttonH = 49 - buttonY * 2.f;
        CGFloat buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button setTitle:@"个人设置" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//        button.backgroundColor = [UIColor whiteColor];
    }
    
    //    UIButton *b = (UIButton *)[self.superview viewWithTag:2];
    //    b.y = 6;
    //    b.height += 7;
    //    b.width += 20;
    //    b.centerX = self.superview.centerX;
    //    self.publicButton = (UIButton *)[self.superview viewWithTag:2];
    
    // 制作 动画 效果
    
    //    UIButton *me = (UIButton *)[self.superview viewWithTag:4];
    //    MyBadgeValue *red = [MyBadgeValue shareMyBadgeValue];
    //    [me addSubview:red];
    //    red.frame = CGRectMake(me.width * 0.7, me.height * 0.1, 6, 6);
    //    red.layer.cornerRadius = 3;
    
}

@end
