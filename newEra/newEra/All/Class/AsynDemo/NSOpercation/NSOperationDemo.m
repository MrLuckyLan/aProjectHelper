//
//  NSOperationDemo.m
//  newEra
//
//  Created by lantian on 2017/7/20.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "NSOperationDemo.h"

@implementation NSOperationDemo



// NSInvocationOperation 简单用法
+ (void)generalNSInvocationOperation
{
    /*
     可以传递一个 NSObject 给operation的操作方法
     我们可以看到NSInvocationOperation其实是同步执行的，
     因此单独使用的话，这个东西也没有什么卵用，
     它需要配合我们后面介绍的NSOperationQueue去使用才能实现多线程调用，
     所以这里我们只需要记住有这么一个东西就行了
     */
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"value1" forKey:@"key1"];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:[self class] selector:@selector(operationSelector:) object:dict];
    NSLog(@"start before");
    [op start];
    NSLog(@"start after");
}
+ (void)operationSelector:(NSDictionary *)dict
{
     NSLog(@"在第%@个线程",[NSThread currentThread]);
    NSLog(@"mainThread = %@", [NSThread mainThread]);
}

// NSBlockOperation 简单用法
+ (void)generalNSBlockOperation
{
    /**
     通过多次不同结果的比较，我们可以看到，NSBlockOperation确实实现了多线程。
     但是我们可以看到，它并非是将所有的block都放到放到了子线程中。
     通过上面的打印记录我们可以发现，它会优先将block放到主线程中执行，(不一定在哪个block中)
     若主线程已有待执行的代码，就开辟新的线程，但最大并发数为4（包括主线程在内）。
     如果block数量大于了4，那么剩下的Block就会等待某个线程空闲下来之后被分配到该线程，且依然是优先分配到主线程。
     而如果我使用真机来跑的话，最大并发数始终为2。因此，具体的最大并发数和运行环境也是有关系的。
     */
    NSBlockOperation * blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1在第%@个线程",[NSThread currentThread]);
        NSLog(@"1haha");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"2在第%@个线程",[NSThread currentThread]);
        NSLog(@"2haha");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
        NSLog(@"3haha");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"4在第%@个线程",[NSThread currentThread]);
        NSLog(@"4haha");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"5在第%@个线程",[NSThread currentThread]);
        NSLog(@"5haha");
    }];
    [blockOperation start];
}

// NSOperationQueue 用法
+ (void)operationQueueInvocation
{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"value1" forKey:@"key1"];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:[self class] selector:@selector(operationSelector:) object:dict];
    NSLog(@"start before");
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
    
    /*
     放入队列中的NSOperation对象不需要调用start方法，
     NSOPerationQueue会在『合适』的时机去自动调用
     */
//    [op start];
    
}

+ (void)operationQueueBlock
{
    /**
     NSBlockOperation中的每一个Block也是异步执行且都在子线程中执行，
     每一个Block内部也依然是同步执行。
     */
    NSBlockOperation * blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1在第%@个线程",[NSThread currentThread]);
        NSLog(@"1haha");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"2在第%@个线程",[NSThread currentThread]);
        NSLog(@"2haha");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
        NSLog(@"3haha");
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:blockOperation];
}

// NSOperationQueue 简单使用
+ (void)operationQueueEazyFun
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"1在第%@个线程",[NSThread currentThread]);
        NSLog(@"1haha");
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
        NSLog(@"3haha");
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
        NSLog(@"3haha");
    }];
}


// NSOperation 依赖关系
+ (void)operationDependence
{
    // NSInvocationOperation
    NSInvocationOperation *o1 = [[NSInvocationOperation alloc] initWithTarget:[self class] selector:@selector(func1) object:@"param"];
    NSInvocationOperation *o2 = [[NSInvocationOperation alloc] initWithTarget:[self class] selector:@selector(func2) object:@"param"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [o2 addDependency:o1];
    [queue addOperation:o1];
    [queue addOperation:o2];
    
    // NSBlockOperation
    NSBlockOperation * blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"blockOperation111在第%@个线程",[NSThread currentThread]);
    }];
    NSBlockOperation * blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation222在第%@个线程",[NSThread currentThread]);
    }];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    [blockOperation2 addDependency:blockOperation1];
    [queue2 addOperation:blockOperation1];
    [queue2 addOperation:blockOperation2];
}

+ (void)func1
{
    sleep(3);
    NSLog(@"我是op1  我在第%@个线程",[NSThread currentThread]);
}
+ (void)func2
{
    NSLog(@"我是op2 我在第%@个线程",[NSThread currentThread]);
}


// 设置最大并发数 maxConcurrentOperationCount
+ (void)setOperationCount
{
    /*
     最大并发数是有上限的，
     设置最大并发数一定要在NSOperationQueue初始化后立即设置，因为上面说过，被放到队列中的NSOperation对象是由队列自己决定何时执行的，有可能你这边一添加立马就被执行。因此要想让设置生效一定要在初始化后立即设置
     */
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    
    [queue addOperationWithBlock:^{
        NSLog(@"1在第%@个线程",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"4在第%@个线程",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"5在第%@个线程",[NSThread currentThread]);
    }];
}








@end
