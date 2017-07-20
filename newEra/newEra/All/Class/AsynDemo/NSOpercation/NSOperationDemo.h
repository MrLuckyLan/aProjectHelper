//
//  NSOperationDemo.h
//  newEra
//
//  Created by lantian on 2017/7/20.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationDemo : NSObject





// NSInvocationOperation 简单用法
+ (void)generalNSInvocationOperation;

// NSBlockOperation 简单用法
+ (void)generalNSBlockOperation;

// NSInvocationOperation 加入到 NSOperationQueue 用法
+ (void)operationQueueInvocation;

// NSInvocationOperation 加入到 NSBlockQueue 用法
+ (void)operationQueueBlock;

// NSOperationQueue 简单使用
+ (void)operationQueueEazyFun;

// NSOperation 依赖关系
+ (void)operationDependence;

// 设置最大并发数 maxConcurrentOperationCount
+ (void)setOperationCount;

// 暂停和取消
+ (void)cancelAndPause;

// 队列完成回调
+ (void)completeBlock;

@end
