//
//  OneViewController.m
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "AllHeader.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "LtTabBarView.h"




@interface OneViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dateDemoData;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateDemoData =
  @[@"0",@"1",@"2",@"3",@"4",@"跳转Item", @"控制 badgeValue", @"动画隐藏tabbar", @"动画显示tabbar"];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        NSDate *date = [NSDate date];
        NSLog(@"date %lld", [date timestamplong13]); // 要 转成时间戳
         NSLog(@"date %@", [date timestampNSString13]); // 要 转成时间戳
        NSLog(@"%@", [date dateToString]);
        NSLog(@"%@", [NSDate stringToDate:@"1999-09-09"]);
        NSLog(@"confromTimespStr =  %@",[NSDate timestampNSDate13withDateStr:[date timestampNSString13]]);
        NSLog(@"%@", [NSDate compareCurrentTime:[@"1499321081000" longLongValue]]);
        NSLog(@"%@", [NSDate getStringWithTimestamp:[@"1499321081000" longLongValue] formatter:@"YYYY-MM-dd hh:mm:ss"]);
        NSLog(@"%d", [[NSDate stringToDate:@"2017-07-05"] isTomorrow]);
        
//        UIHeight(1);
        
    }else if (1 == indexPath.row){
        NSLog(@"ISPAD : %d", ISPAD);
        NSLog(@"ISPHONE : %d", ISPHONE);
        [self.navigationController pushViewController:[TwoViewController new] animated:YES];
    }else if (2 == indexPath.row){
        NSLog(@"\n%@\n%@\n%@", API_DNS,AliPayKey,WechatKey);
//        NSLog(@"%@/%@", _Environment_Domain,_Login_URL);
        [self.navigationController pushViewController:[ThreeViewController new] animated:YES];
    }else if (3 == indexPath.row){
        NSLog(@"\n%@\n%@\n%@", API_DNS,AliPayKey,WechatKey);
        //        NSLog(@"%@/%@", _Environment_Domain,_Login_URL);
        [self.navigationController pushViewController:[ThreeViewController new] animated:YES];
    }else if (4 == indexPath.row){
        NSLog(@"\n%@\n%@\n%@", API_DNS,AliPayKey,WechatKey);
        //        NSLog(@"%@/%@", _Environment_Domain,_Login_URL);
        [self.navigationController pushViewController:[ThreeViewController new] animated:YES];
    }else if (5 == indexPath.row){
        
        [UIWindow selectedItemIndex:1];
        
    }else if (6 == indexPath.row){
        
        [UIWindow ItemAtIndex:2 BadgeShow:YES BadgeValue:60];
    }
    else if (7 == indexPath.row){
        [LtTabBarView TabBarHidden:YES animated:YES];
    }
    else if (8 == indexPath.row){
        [LtTabBarView TabBarHidden:NO animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.666;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dateDemoData[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateDemoData.count;
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
