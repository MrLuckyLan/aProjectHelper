//
//  UIBaseViewController.m
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "AppRootWindow.h"
#import "UIBaseViewController.h"
#import "UIWindow+Extension.h"

@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


- (void)buttonClicked
{
    NSLog(@"adsfhjadfshjadfsadf");
//     UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    MJTabBarController *tab = (MJTabBarController *)window.rootViewController;
//    tab.myselectedIndex = 1;
//    UIResponder *appdelegate = [UIApplication sharedApplication].delegate;
//     AppRootWindow *window = (AppRootWindow *)[[UIApplication sharedApplication].delegate window];
//    [window setDefaultController];
    
    [UIWindow selectedItemIndex:0];
////    [UIWindow selectedItemIndex:1];
//    
//    UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    MJTabBarController *tab = (MJTabBarController *)window.rootViewController;
//    tab.privateSelectedIndex = 0;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
