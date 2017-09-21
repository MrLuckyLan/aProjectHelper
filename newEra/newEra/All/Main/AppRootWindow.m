//
//  AppRootWindow.m
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "AppRootWindow.h"
#import "UIGuideViewController.h"
#import "LtTabBarController.h"

@interface AppRootWindow ()



/**
 默认主UI tabBarController
 */
@property (nonatomic,strong) LtTabBarController *defaultRootController;

/**
 介绍新版本
 */
@property (nonatomic, strong) UIGuideViewController *guideController;







@end

@implementation AppRootWindow


- (instancetype)init
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor whiteColor];
        [self setRootController];
    }
    return self;
}



- (void)setRootController
{
    
    [self setDefaultController];
    [self makeKeyAndVisible];
    
    // 新版本提醒
    /*
     WypCurrentVersion (本地自己写的,也是每次发布填写到appStore的版本信息)
     AppStoreVersion (当前appstore 存在的玩一票App最大版本号) [ 系统方法 ]
     
     if(AppStoreVersion > WypCurrentVersion)
     {
     更新提醒
     这个逻辑没毛病
     }
     
     
     */
    
    

//      [self loadGuideController]; // 加载引导页
    
}

- (void)setDefaultController
{
    self.rootViewController = self.defaultRootController;
//    self.rootViewController = [[LtTabBarController alloc] init];
}





- (void)loadGuideController
{
    
    /**首次加载引导页*/
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt"];
//        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg"];
        self.guideController = [[UIGuideViewController alloc] initWithCoverImageNames:coverImageNames];
        self.guideController.autoScrolling = NO;
        self.guideController.hiddenEnterButton = YES;
        [self addSubview:self.guideController.view];
    
        __weak AppRootWindow *weakSelf = self;
        self.guideController.didSelectedEnter = ^() {
            weakSelf.guideController = nil;
        };
    
}


// lazyLoad
- (LtTabBarController *)defaultRootController
{
    if (!_defaultRootController) {
        _defaultRootController = [[LtTabBarController alloc] init];
    }
    return _defaultRootController;
}









@end
