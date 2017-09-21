//
//  NSOperationDemo.m
//  newEra
//
//  Created by lantian on 2017/7/20.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "NSOperationDemo.h"

@interface NSOperationDemo ()
{
    NSOperationQueue *opQueue;
}

@end

@implementation NSOperationDemo



// NSInvocationOperation 简单用法
+ (void)generalNSInvocationOperation
{
    /*
     可以传递一个 参数
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
    NSBlockOperation * blockOperation =
    [NSBlockOperation blockOperationWithBlock:^{
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
    NSInvocationOperation *op = [[NSInvocationOperation alloc]
                                 initWithTarget:[self class]
                                 selector:@selector(operationSelector:)
                                 object:dict];
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
        NSLog(@"在第%@个线程",[NSThread currentThread]);
        // 回到主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新UI......%@", [NSThread currentThread]);
        }];
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
    
    /*
     NSOperation的对象 (NSBlockOperation *) (NSInvocationOperation* )都一个queuePriority属性，表示队列优先级
     cpu会尽力将资源给高优先级的，尽量使高优先级的先执行，但优先级具有随机行，并不是高的就一定先执行
     
     它是一个枚举值，有这么几个等级可选
     typedef NS_ENUM(NSInteger, NSOperationQueuePriority) {
     NSOperationQueuePriorityVeryLow = -8L,
     NSOperationQueuePriorityLow = -4L,
     NSOperationQueuePriorityNormal = 0,
     NSOperationQueuePriorityHigh = 4,
     NSOperationQueuePriorityVeryHigh = 8
     };
     
     */
    
}

+ (void)cancelAndPause
{
    /*
    NSOperationQueue提供暂停和取消两种操作。
    设置暂停只需要设置queue的suspended属性为YES或NO即可
    取消你可以选择调用某个NSOperation的cancle方法，也可以调用Queue的cancelAllOperations方法来取消全部线程
    
    这里需要强调的是，所谓的暂停和取消并不会立即暂停或取消当前操作，而是不在调用新的NSOperation。
    */
    
    [[NSOperationDemo new] pause];
    [[NSOperationDemo new] cancel];
}


// 就是暂停和继续:  对队列的操作
/**
 应用场景一：
 比如当我们在有WiFi的地发用手机下载电影，但是有事情走开了，断网了电影只下载了一半，这时就需要挂起
 等到了有网的地方又可以接着原来的进度下载
 切记：挂起的是队列，不会影响已经在执行的操作
 应用场景二：
 在tableview界面，开线程下载远程的网络界面，对UI会有影响，使用户体验变差
 那么这种情况，就可以设置在用户操作UI（如滚动屏幕）的时候，暂停队列（不是取消队列
 停止滚动的时候，恢复队列。
 */
- (void)pause
{
    
    // 判断操作的数量，当前队列里面是否有操作
    if(opQueue.operationCount == 0){
        NSLog(@"没有操作");
        return; // 没有操作的时候直接return，不会修改队列的状态
    }
    
    // 暂停继续 :
    opQueue.suspended = !opQueue.suspended;
    if(opQueue.suspended){
        NSLog(@"暂停");
    }else
    {
        NSLog(@"继续");
    }
}


- (void)cancel
{
    // 取消队列内的所有操作
    // 只是取消队列里的任务，而正在执行的任务是无法取消的
    // 另外取消了任务就是删除了队列内的所有操作
    [opQueue cancelAllOperations];
    NSLog(@"取消所有操作");
    
    // 取消队列的挂起状态(只要是取消了队列的操作，我们就把队列处于一个启动状态，以便于后续的开始)
    opQueue.suspended = NO;
}

// 队列完成回调
+ (void)completeBlock
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"-operation-下载图片-%@",[NSThread currentThread]);
        }
    }];
    //监听操作的执行完毕
    operation.completionBlock=^{
        NSLog(@"--接着下载第二张图片--");
    };
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}




@end
