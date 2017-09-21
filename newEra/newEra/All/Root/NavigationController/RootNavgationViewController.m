//
//  RootNavgationViewController.m
//  newEra
//
//  Created by Zixiang on 2017/9/21.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "LtTabBarView.h"
#import "RootNavgationViewController.h"

@interface RootNavgationViewController ()<UINavigationControllerDelegate>

@end

@implementation RootNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"---RootNavgationViewController---");
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
     NSLog(@"---willShowViewController---");
    if (self.viewControllers.count == 1) {
        [LtTabBarView show];
    }else{
        [LtTabBarView hidden];
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}





- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /**
     系统自带tabBar的时候
     if (self.viewControllers.count > 0) {
     viewController.hidesBottomBarWhenPushed = YES;
     }
     [super pushViewController:viewController animated:animated];
     */
    
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
    [super pushViewController:viewController animated:animated];
    
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
