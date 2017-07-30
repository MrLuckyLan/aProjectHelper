//
//  ReactiveCocoaController.m
//  newEra
//
//  Created by lantian on 2017/7/20.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "ReactiveCocoaController.h"

typedef void(^BLOCK)();

@interface ReactiveCocoaController ()




@property (nonatomic,copy) NSString *strCopy;
@property (nonatomic,strong) NSString *strStrong;
@property (nonatomic,copy) BLOCK block;


@end

@implementation ReactiveCocoaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableString *sourceStr = [NSMutableString stringWithString:@"hello"];
    self.strCopy = sourceStr; /*深拷贝 新内存*/
    self.strStrong = sourceStr; /*浅拷贝,使用sourceStr地址*/
    [sourceStr appendString:@" world"];
    NSLog(@"%@",  self.strCopy); //hello
    NSLog(@"%@",  self.strStrong); //hello world
}

- (void)different
{
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@", strongSelf);
    };
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
