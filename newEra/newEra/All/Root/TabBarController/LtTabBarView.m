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


//@property (nonatomic,strong) UIView *badge0;
//@property (nonatomic,strong) UIView *badge1;
//@property (nonatomic,strong) UIView *badge2;
//@property (nonatomic,strong) UIView *badge3;
//@property (nonatomic,strong) UIView *badge4;


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

+ (void)TabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    LtTabBarView *tabar = [LtTabBarView shareTabBar];
    NSTimeInterval time = animated ? 0.3 : 0.0;
    // (循环)
//    if (tabar.isHidden) {
    if (NO == hidden) {
        tabar.hidden = NO;
        [UIView animateWithDuration:time animations:^{
            tabar.transform = CGAffineTransformIdentity;
        }];
    }else{
        CGFloat h = tabar.frame.size.height;
        [UIView animateWithDuration:time-0.1 animations:^{
            tabar.transform = CGAffineTransformMakeTranslation(0,h);
        }completion:^(BOOL finished) {
            tabar.hidden = YES;
        }];
    }
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
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    /*
     * 满足特殊变态需求,例如微博咸鱼等中间按钮模态事件 条件一
     *
     if ((2 + TAG) == button.tag) {
     
     }else{
        self.selectButton.selected = NO;
        button.selected = YES;
        self.selectButton = button;
     }

     *
     *
     */
    
}


- (void)setUpItem
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSInteger count = self.subviews.count;
        NSArray *arr = @[@"首页",@"任务",@"消息",@"办公",@"通讯录"];
        for (int i = 0 ; i < count ; i++) {
            LtTabBarBtn *button = self.subviews[i];
            button.tag =TAG + i;
            // 设置frame
            CGFloat buttonY = 2;
            CGFloat buttonW = self.frame.size.width / count;
            CGFloat buttonH = 40;
            CGFloat buttonX = i * buttonW;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            [button setTitle:arr[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:10.f];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            if (i == 1) {
                [button badgeStyle:Number_BadgeStyle];
            }
            if (i == 2) {
                [button badgeStyle:Number_BadgeStyle];
            }
            if (i == 3) {
                [button badgeStyle:Normal_BadgeStyle];
            }
        }
    });
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpItem];
}


- (void)ItemAtIndex:(int)index BadgeShow:(BOOL)show BadgeValue:(int)num
{
    [self setUpItem];
    LtTabBarBtn *button = (LtTabBarBtn *)[self viewWithTag:(TAG + index)];
    switch (index) {
        case 0:
            
            break;
        case 1:
        {
            [button badgeStyle:Number_BadgeStyle];
            [button badgeNormalShow:show];
        }
            break;
        case 2:
        {
            [button badgeStyle:Number_BadgeStyle];
            [button badgeNum:num];
        }
            
            break;
        case 3:
        {
            [button badgeStyle:Normal_BadgeStyle];
            [button badgeNum:num];
        }
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}





@end
