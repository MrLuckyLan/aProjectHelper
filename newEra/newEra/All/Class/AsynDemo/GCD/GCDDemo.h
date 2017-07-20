//
//  GCDDemo.h
//  newEra
//
//  Created by lantian on 2017/7/20.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDDemo : NSObject










// 主队列同步任务 阻塞
+ (void)main_queue_sync;

// 主队列 异步任务
+ (void)main_queue_async;

// 串行队列  同步任务
+ (void)serial_sync;

// 串行队列  异步任务
+ (void)serial_async;

// 并发队列  同步任务
+ (void)concurrent_sync;

// 并发队列 异步任务
+ (void)concurrent_async;

// 线程阻塞 二
+ (void)blocked;

// barrier
+ (void)barrier;

// group
+ (void)group;


// 线程锁等
+ (void)specail;






@end
