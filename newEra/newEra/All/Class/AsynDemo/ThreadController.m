//
//  ThreadController.m
//  newEra
//
//  Created by lantian on 2017/7/14.
//  Copyright © 2017年 LT. All rights reserved.
//


#import "GCDDemo.h"
#import "ThreadController.h"
#import "NSOperationDemo.h"

@interface ThreadController ()



@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;




@end

@implementation ThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 主队列同步任务 阻塞 一
- (IBAction)main_queue_sync:(UIButton *)sender {
    [GCDDemo main_queue_sync];
}
// 主队列 异步任务
- (IBAction)main_queue_async:(UIButton *)sender {
    [GCDDemo main_queue_async];
}
// 串行队列  同步任务
- (IBAction)serial_sync:(id)sender {
    [GCDDemo serial_sync];
}
// 串行队列  异步任务
- (IBAction)serial_async:(UIButton *)sender {
    [GCDDemo serial_async];
}
// 并发队列  同步任务
- (IBAction)concurrent_sync:(UIButton *)sender {
    [GCDDemo concurrent_sync];
}
// 并发队列 异步任务
- (IBAction)concurrent_async:(UIButton *)sender {
    [GCDDemo concurrent_async];
}
// 线程阻塞 二
- (IBAction)blocked:(UIButton *)sender {
    [GCDDemo blocked];
}
// barrier
- (IBAction)barrier:(UIButton *)sender {
    [GCDDemo barrier];
}
// group
- (IBAction)group:(UIButton *)sender {
    [GCDDemo group];
}
// 优先级 锁
- (IBAction)specail:(UIButton *)sender {
    [GCDDemo specail];
}


// NSInvocationOperation 简单用法
- (IBAction)NSInvocationOperation:(UIButton *)sender {
    [NSOperationDemo generalNSInvocationOperation];
}
// NSBlockOperation 简单用法
- (IBAction)NSBlockOperation:(UIButton *)sender {
    [NSOperationDemo generalNSBlockOperation];
}

// NSInvocationOperation 加入到 NSOperationQueue 用法
- (IBAction)NSOperationQueue_NSInvocationOperation:(UIButton *)sender {
    [NSOperationDemo operationQueueInvocation];
}

// NSInvocationOperation 加入到 NSBlockQueue 用法
- (IBAction)NSOperationQueue_NSBlockOperation:(UIButton *)sender {
    [NSOperationDemo operationQueueBlock];
}

// NSOperationQueue 简单使用
- (IBAction)operationQueueEazyFunc:(UIButton *)sender {
    [NSOperationDemo operationQueueEazyFun];
}

// NSOperation 依赖关系
- (IBAction)operationDependence:(UIButton *)sender {
    [NSOperationDemo operationDependence];
}

// 设置最大并发数
- (IBAction)setOperationCount:(UIButton *)sender {
    [NSOperationDemo setOperationCount];
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





























@end
