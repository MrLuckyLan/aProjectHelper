//
//  UIWindow+Extension.m
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//


#import "AppRootWindow.h"
#import "UIWindow+Extension.h"
#import "LtTabBarController.h"

@implementation UIWindow (Extension)




+ (void)ItemAtIndex:(int)index BadgeShow:(BOOL)show BadgeValue:(int)num
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    LtTabBarController *tab = (LtTabBarController *)window.rootViewController;
    [tab ItemAtIndex:index BadgeShow:show BadgeValue:num];
}


+ (void)selectedItemIndex:(int)index
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    LtTabBarController *tab = (LtTabBarController *)window.rootViewController;
    tab.privateSelectedIndex = index;
}


- (void)startUpRootController
{
//    AppRootWindow *window = (AppRootWindow *)[[UIApplication sharedApplication].delegate window];
//    [window setRootController];
}



- (void)defaultRootController
{
//    AppRootWindow *window = (AppRootWindow *)[[UIApplication sharedApplication].delegate window];
//    [window setDefaultController];
}






+ (UIViewController *)getCurrentVC
{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}












@end
