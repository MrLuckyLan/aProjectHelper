//
//  LtTabBarController
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技. All rights reserved.
//


#import "LtTabBarView.h"
#import "LtTabBarController.h"
#import "LtTabBarBtn.h"
#import "UIWindow+Extension.h"



#import "ThreadController.h"
#import "MVVMController.h"
#import "OneViewController.h"
#import "RunTimeController.h"
#import "RunLoopController.h"
#import "CoreAnimaitionController.h"
#import "ReactiveCocoaController.h"
#import "RootNavgationViewController.h"

#define TAG 600

@interface LtTabBarController ()<LtTabBarViewDelegate>

@property (nonatomic,strong) LtTabBarView *ltTabBar;





@end

@implementation LtTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)ItemAtIndex:(int)index BadgeShow:(BOOL)show BadgeValue:(int)num
{
    [self.ltTabBar ItemAtIndex:index BadgeShow:YES BadgeValue:10];
}
- (void)cleanAllBadge
{
    [self.ltTabBar ItemAtIndex:0 BadgeShow:NO BadgeValue:0];
    [self.ltTabBar ItemAtIndex:1 BadgeShow:NO BadgeValue:0];
    [self.ltTabBar ItemAtIndex:2 BadgeShow:NO BadgeValue:0];
    [self.ltTabBar ItemAtIndex:3 BadgeShow:NO BadgeValue:0];
    [self.ltTabBar ItemAtIndex:4 BadgeShow:NO BadgeValue:0];
}

// setter self.selectedIndex -> index
- (void)setPrivateSelectedIndex:(int)privateSelectedIndex
{
    _privateSelectedIndex = privateSelectedIndex;
    privateSelectedIndex  = privateSelectedIndex ? : 0;
    LtTabBarBtn * temp    = [self.ltTabBar viewWithTag:privateSelectedIndex + TAG];
    [self.ltTabBar buttonClick:temp];
}
// delegate
- (void)tabBar:(LtTabBarView *)tabBar didSelectItemFrom:(NSInteger)from to:(NSInteger)to
{
    /*
     * 满足特殊变态需求,例如微博咸鱼等中间按钮模态事件 条件二
     *
     if (2 == to) {
        [self presentViewController......]
     }else{
        self.selectedIndex = to;
     }
     */
    self.selectedIndex = to;
}





- (void)setUp
{
    // TODO 将来写成懒加载
    ThreadController *vc1 = [[ThreadController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    RunTimeController *vc2 = [[RunTimeController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    RunLoopController *vc3 = [[RunLoopController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    OneViewController *vc4 = [[OneViewController alloc] init];
    RootNavgationViewController *nav4 = [[RootNavgationViewController alloc] initWithRootViewController:vc4];
    
    ReactiveCocoaController *vc5 = [[ReactiveCocoaController alloc] init];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    /*
     * 满足特殊变态需求,例如微博咸鱼等中间按钮模态事件 条件三
     * 创建 self.viewControllers数组中 需要模态的地方旧要传入一个任意站位nav
     */
     
    self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    
    int type = 1; // 0 系统自带的TabBar 1 自定义
    if (0 == type) {
        nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Thread" image:[UIImage imageNamed:@"tab1"] selectedImage:[UIImage imageNamed:@"tabsel1"]];
        nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"runtime" image:[UIImage imageNamed:@"tab2"] selectedImage:[UIImage imageNamed:@"tabsel2"]];
        nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"runloop" image:[UIImage imageNamed:@"tab3"] selectedImage:[UIImage imageNamed:@"tabsel3"]];
        nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"other" image:[UIImage imageNamed:@"tab4"] selectedImage:[UIImage imageNamed:@"tabsel4"]];
        nav5.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"RAC" image:[UIImage imageNamed:@"tab5"] selectedImage:[UIImage imageNamed:@"tabsel5"]];
        
    }else{
        //    [self.tabBar removeFromSuperview]; // 移除系统自带的tabBar
        self.tabBar.backgroundColor = [UIColor grayColor];
        self.tabBar.hidden = YES;
        [self.view addSubview:self.ltTabBar];
    }
    
}


- (LtTabBarView *)ltTabBar
{
    if (!_ltTabBar) {
        _ltTabBar = [LtTabBarView shareTabBar];
        [_ltTabBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i = 0; i < self.viewControllers.count; i++) {
            NSString *name = [NSString stringWithFormat:@"tab%d", i + 1];
            NSString *selName = [NSString stringWithFormat:@"tabsel%d", i + 1];
            [_ltTabBar addTabBarButtonWithName:name selName:selName];
        }
        _ltTabBar.delegate = self;
        _ltTabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44);
        _ltTabBar.backgroundColor = [UIColor grayColor];
        [_ltTabBar ItemAtIndex:1 BadgeShow:YES BadgeValue:10];
        [_ltTabBar ItemAtIndex:2 BadgeShow:YES BadgeValue:0];
        [_ltTabBar ItemAtIndex:3 BadgeShow:YES BadgeValue:10];
    }
    return _ltTabBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
