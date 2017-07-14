//
//  TwoViewController.m
//  newEra
//
//  Created by lantian on 2017/7/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "AllHeader.h"
#import "TwoViewController.h"

@interface TwoViewController ()
{
    UIImageView *image;
    UIImage *sourceimage;
}

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    sourceimage = [UIImage imageNamed:@"unknown.jpg"];
    self->image = [[UIImageView alloc] initWithImage:sourceimage];
    image.frame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height / 2.f);
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:image];
    self.view.backgroundColor = AppDefaultBackColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(handleImg)];
    
    
//    tab3
//    typedef NS_ENUM(NSUInteger, GraphicBT_Type) {
//        GraphicBT_Type_IMGUP = 1,
//        GraphicBT_Type_IMGLEFT,
//        GraphicBT_Type_IMGRIGHT,
//    };

    FreeUIBtn *btn = [[FreeUIBtn alloc] initWithFrame:CGRectMake(150, 150, 60, 60) withIMG:[UIImage imageNamed:@"tab3"] title:@"按钮的样式" type:FreeUIBtn_Type_IMGUP];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    FreeUIBtn *btn1 = [[FreeUIBtn alloc] initWithFrame:CGRectMake(150, 210, 60, 60) withIMG:[UIImage imageNamed:@"tab3"] title:@"按钮的样式" type:FreeUIBtn_Type_IMGLEFT];
    [self.view addSubview:btn1];
    
    FreeUIBtn *btn2 = [[FreeUIBtn alloc] initWithFrame:CGRectMake(150, 270, 60, 60) withIMG:[UIImage imageNamed:@"tab3"] title:@"按钮的样式" type:FreeUIBtn_Type_IMGRIGHT];
    [self.view addSubview:btn2];
    
    btn2.backgroundColor = RGB(100, 100, 10);

    
}


- (void)handleImg
{
//    image.image = [sourceimage cropImageWithSize:CGSizeMake(100, 100)];
//    image.image = [sourceimage imageWithStringWaterMark:@"@蓝天白云看" atPoint:CGPointZero color:[UIColor blueColor] font:[UIFont systemFontOfSize:15.f]];
    
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
