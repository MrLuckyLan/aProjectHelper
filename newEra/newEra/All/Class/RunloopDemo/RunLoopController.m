//
//  RunLoopController.m
//  newEra
//
//  Created by lantian on 2017/7/20.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "RunLoopController.h"

@interface RunLoopController ()<UIWebViewDelegate>







@end

@implementation RunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *wb = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:wb];
    NSURLRequest *q = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://wap.aichensmart.com/Information/show/information_id/251/aMethod/H5/aType/none/aId/0.html"]];
    [wb loadRequest:q];
    wb.delegate = self;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *js = @"document.getElementsByName(\"description\")[0].content";
    NSString *oko = [webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"==============%@", oko);
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
