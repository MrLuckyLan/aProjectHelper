//
//  GCDDemo.m
//  newEra
//
//  Created by lantian on 2017/7/20.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "GCDDemo.h"

@implementation GCDDemo




/*
 同步执行	                            异步执行
 
 串行队列	 当前线程，一个一个执行	   会开启新的线程，但是任务是串行的，执行完一个任务，再执行下一个任务
 并行队列	 当前线程，一个一个执行	   开很多线程，一起执行
 主队列       阻塞                                   只在主线程
 
 线程阻塞 一: 主队列同步任务
 线程阻塞二: 串行队列同步或异步任务中 同步任务
 
 
 快速迭代
 - (void)apply
 
 信号量
 dispatch_semaphore_creat
 
 
 我们使用GCD的时候如何让线程同步，目前我能想到的就三种
 
 1.dispatch_group
 2.dispatch_barrier
 3.dispatch_semaphore
 
 
 */





// 主队列同步任务 阻塞 一
+ (void)main_queue_sync{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    NSLog(@"之前 - %@", [NSThread currentThread]);
    dispatch_sync(mainQueue, ^{
        NSLog(@"sync - %@", [NSThread currentThread]);
    });
    NSLog(@"之后 - %@", [NSThread currentThread]);
    /*
     同步任务会阻塞当前线程，然后把 Block 中的任务放到指定的队列中执行，只有等到 Block 中的任务完成后才会让当前线程继续往下运行。
     那么这里的步骤就是：
     打印完第一句后，dispatch_sync 立即阻塞当前的主线程，然后把 Block 中的任务放到 main_queue 中，
     可是 main_queue 中的任务会被取出来放到主线程中执行，但主线程这个时候已经被阻塞了，所以 Block 中的任务就不能完成，
     它不完成，dispatch_sync 就会一直阻塞主线程，这就是死锁现象。导致主线程一直卡死。
     */
}
// 主队列 异步任务
+ (void)main_queue_async{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"1\n%@", [NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"2\n%@", [NSThread currentThread]);
    });
}

// 串行队列  同步任务
+ (void)serial_sync{
    NSLog(@"\n%@", [NSThread currentThread]);
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_sync", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
    dispatch_sync(serialQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
}


// 串行队列  异步任务
+ (void)serial_async{
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_sync", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
}

// 并发队列  同步任务
+ (void)concurrent_sync{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_sync", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
}

// 并发队列 异步任务
+ (void)concurrent_async{
    //    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_async", DISPATCH_QUEUE_CONCURRENT);
    // 全局并发
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"\n%@", [NSThread currentThread]);
    });
}

// 线程阻塞 二
+ (void)blocked{
    
    NSLog(@"a \n%@", [NSThread currentThread]);
    dispatch_queue_t serialQueue = dispatch_queue_create("blocked", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"b \n%@", [NSThread currentThread]);
        dispatch_sync(serialQueue, ^{
            NSLog(@"c \n%@", [NSThread currentThread]);
        });
    });
    NSLog(@"d \n%@", [NSThread currentThread]);
    
}


// barrier
+ (void)barrier{
    // 自定义 并发队列可以使用 dispatch_barrier_async
    dispatch_queue_t queue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1 \n%@", [NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"======================================");
    });
    dispatch_async(queue, ^{
        NSLog(@"2 \n%@", [NSThread currentThread]);
    });
}

// group
+ (void)group{
    
    dispatch_queue_t currentQueue = dispatch_queue_create("group.com", DISPATCH_QUEUE_CONCURRENT); //DISPATCH_QUEUE_SERIAL
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, currentQueue, ^{
        sleep(3);
        NSLog(@"0");
    });
    dispatch_group_async(group, currentQueue, ^{
        sleep(3);
        NSLog(@"1");
    });
    dispatch_group_notify(group, currentQueue, ^{
        NSLog(@"222");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"==================");
        });
    });
}

// 快速迭代
+ (void)apply {
    //1.创建NSArray类对象
    NSArray *array = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j"];
    
    //2.创建一个全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //3.通过dispatch_apply函数对NSArray中的全部元素进行处理,并等待处理完成,
    dispatch_apply([array count], queue, ^(size_t index) {
//        NSLog(@"%zu: %@", index, [array objectAtIndex:index]);
        NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"done");
    /*!
     *  @brief  输出结果
     *
     2016-02-25 19:37:17.308 dispatch_apply测试[3010:167871] 0: a
     2016-02-25 19:37:17.308 dispatch_apply测试[3010:167956] 1: b
     2016-02-25 19:37:17.308 dispatch_apply测试[3010:167957] 3: d
     2016-02-25 19:37:17.308 dispatch_apply测试[3010:167871] 4: e
     2016-02-25 19:37:17.309 dispatch_apply测试[3010:167957] 6: g
     2016-02-25 19:37:17.309 dispatch_apply测试[3010:167871] 7: h
     2016-02-25 19:37:17.309 dispatch_apply测试[3010:167957] 8: i
     2016-02-25 19:37:17.309 dispatch_apply测试[3010:167871] 9: j
     2016-02-25 19:37:17.308 dispatch_apply测试[3010:167956] 5: f
     2016-02-25 19:37:17.308 dispatch_apply测试[3010:167955] 2: c
     *  !!!因为在Global Dispatch Queue中执行,所以各个处理的执行时间不定
     但done一定会输出在最后的位置,因为dispatch_apply函数会等待所以的处理结束
     */
}








// 信号量
+ (void)semaphore
{
    /**
     在GCD中有三个函数是semaphore的操作，
     分别是：
     dispatch_semaphore_create 创建一个semaphore
     dispatch_semaphore_signal 发送一个信号
     dispatch_semaphore_wait 等待信号
     */
    
    dispatch_group_t group = dispatch_group_create();
    // 创建信号量，并且设置值为10
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {   // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i===%@",i, [NSThread currentThread]);
            sleep(2);
            // 每次发送信号则semaphore会+1，
            dispatch_semaphore_signal(semaphore);
        });
    }
    
}








// 优先级 锁
+ (void)specail{
    /*
     服务于与用户交互的优先级，该级别任务会占用几乎所有的时间片和 I/O 带宽。可以进行处理主事件循环、视图绘制、动画等操作，
     *  - QOS_CLASS_USER_INTERACTIVE
     // 服务于用户发起并等待的优先级
     *  - QOS_CLASS_USER_INITIATED
     // 默认的优先级
     *  - QOS_CLASS_DEFAULT
     // 用户不太关心任务的进度，但是需要知道结果，比如下拉刷新操作
     *  - QOS_CLASS_UTILITY
     // 用户不会察觉的任务，比如，预加载一些数据，
     *  - QOS_CLASS_BACKGROUND
     */
    
    /**
     1.资源共享
     并发编程中许多问题的根源就是在多线程中访问共享资源。资源可以是一个属性、一个对象，通用的内存、网络设备和文件等等。在多线程中任意共享的资源都有一个潜在的冲突，开发者必须防止相关冲突的发生。
     
     为了演示冲突问题，我们来看一个关于资源的简单示例：利用一个整型值作为计数器。在程序运行过程中，有两个并行线程A和B，这两个线程都尝试着同时增加计数器的值。问题来了，通过C或OC写的代码(增加计数器的值)不仅仅是一条指令，而是包括好多指令——要想增加计数器的值，需要从内存中读取出当前值，然后再增加计数器的值，最后还需要就爱那个这个增加的值写回内存中。
     
     我们可以试着想一下，如果两个线程同时做上面涉及到的操作，会发生什么问题。例如，线程A和B都从内存中读取出了计数器的值，假设为17，然后线程A将计数器的值加1，并将结果18写回到内存中。同时，线程B也将计数器的值加1，并将结果18写回到内存中。实际上，此时计数器的值已经被破坏掉了——因为计数器的值17被加1了两次，应该为19，但是内存中的值为18。
     
     这个问题成为资源竞争，或者叫做race condition，在多线程里面访问一个共享的资源，如果没有一种机制来确保线程A结束访问一个共享资源之前，线程B就开始访问该共享资源，那么资源竞争的问题总是会发生。试想一下，如果如果程序在内存中访问的资源不是一个简单的整型，而是一个复杂的数据结构，可能会发生这样的现象：当第一个线程正在读写这个数据结构时，第二个线程也来读这个数据结构，那么获取到的数据可能是新旧参半。为了防止出现这样的问题，在多线程访问共享资源时，需要一种互斥的机制。
     
     在实际的开发中，情况甚至要比上面介绍的复杂，因为现代CPU为了对代码运行达到最优化，对改变从内存中读写数据的顺序（乱序执行）。
     
     2、互斥
     互斥访问的意思就是同一时刻，只允许一个线程访问某个资源。为了保证这一点，每个希望访问共享资源的线程，首先需要获得一个共享资源的互斥锁，一旦某个线程对资源完成了读写操作，就释放掉这个互斥锁，这样别的线程就有机会访问该共享资源了。
     
     除了确保互斥锁的访问，还需要解决代码无序执行所带来的问题。如果不能确保CPU访问内存的顺序跟编程时的代码指令一样，那么仅仅依靠互斥锁的访问是不够的。为了解决由CPU的优化策略引起的代码无序执行，需要引入内存屏障(memory barrier)。通过设置内存屏障，来确保无序执行时能够正确跨越设置的屏障。
     
     当然，互斥锁的实现是需要自由的竞争条件。这实际上是非常重要的一个保证，并且需要在现代CPU上使用特殊的指令。更多关于原子操作(atomic operation)，请阅读Daniel写的文章：底层并发技术。
     
     从语言层面来说，在Objective-C中将属性以atomic的形式来声明，就能支持互斥锁了。实际上，默认情况下，属性是atomic的。将一个属性声明为atomic表示每次访问该属性都会进行加锁和解锁操作。虽然最把稳的做法就是将所有的属性都声明为atomic，但是这也会付出一定的代价。
     
     获取资源上的锁会引发一定的性能代价。获取和释放锁需要自由的竞争条件(race-condition free)，这在多核系统中是很重要的。另外，在获取锁的时候，线程有时候需要等待——因为其它的线程已经获得了资源的锁。这种情况下，线程会进入休眠状态，当其它线程释放掉相关资源的锁时，休眠的线程会得到通知。其实所有这些相关操作都是非常昂贵且复杂的。
     
     这有一些不同类型的锁。当没有竞争时，有些锁是很廉价的(cheap)，但是在竞争情况下，性能就会打折扣。同等条件下，另外一些锁则比较昂贵(expensive)，但是在竞争情况下，会表现更好(锁的竞争是这样产生的：当一个或者多个线程尝试获取一个已经被别的线程获取了的锁)。
     
     在这里有一个东西需要进行权衡：获取和释放锁所带来的开销。开发者需要确保代码中有获取锁和释放锁的语句。同时，如果获取锁之后，要执行一大段代码，这将带来风险：其它线程可能因为资源的竞争而无法工作（需要释放掉相关的锁才行）。
     
     我们经常能看到并行运行的代码，但实际上由于共享资源中配置了相关的锁，所以有时候只有一个线程是出于激活状态的。要想预测一下代码在多核上的调度情况，有时候也显得很重要。我们可以使用Instrument的CPU strategy view来检查是否有效的利用了CPU的可用核数，进而得出更好的想法，以此来优化代码。
     
     3.死锁
     互斥解决了资源竞争的问题，但同时这也引入了一个新的问题：死锁。当多个线程在相互等待着对方的结束时，就会发生死锁，这是程序可能会被卡住。
     
     看看下面的代码——交换两个变量的值：
     
     void swap(A, B)
     {
     lock(lockA);
     lock(lockB);
     int a = A;
     int b = B;
     A = b;
     B = a;
     unlock(lockB);
     unlock(lockA);
     }
     大多数时候，这能够正常运行。但是当两个线程同时调用上面这个方法呢——使用两个相反的值：
     
     swap(X, Y); // thread 1
     swap(Y, X); // thread 2
     此时程序可能会由于死锁而被终止。线程1获得了X的一个锁，线程2获得了Y的一个锁。 接着它们会同时等待另外一把锁，但是永远都不会获得。
     
     记住：在线程之间共享更多的资源，会使用更多的锁，同时也会增加死锁的概率。这也是为什么我们需要尽量减少线程间资源共享，并确保共享的资源尽量简单的原因之一。建议阅读以下底层并发编程API中的doing things asynchronously。
     
     4、饥饿
     当你认为已经足够了解并发编程面临的陷阱 时，拐角处又出现了新的问题。锁定的共享资源会引起读写问题。大多数情况下，限制资源一次只能有一个线程进行访问，这是非常浪费的，比如一个读取锁只允许读，而不对资源进行写操作，这种情况下，同时可能会有另外一个线程等着着获取一个写锁。
     
     为了解决这个问题，更好的方法不是简单使用读/写锁，例如给定一个writer preference，或者使用read-copy-update算法。Daniel在底层并发技术文章中有相关介绍。
     
     5、优先级反转
     本节开头介绍了美国宇航局发射的火星探测器在火星上遇到的并发问题。现在我们就来看看为什么那个火星探测器会失败，以及为什么有时候我们的程序也会遇到相同的问题——该死的优先级反转。
     
     优先级反转是指程序在运行时低优先级的任务阻塞了高优先级的任务，有效的反转了任务的优先级。由于GCD提供了后台运行队列(拥有不同的优先级)，包括I/O队列，所以通过GCD我们可以很好的来了解一下优先级反转的可能性。
     
     高优先级和低优先级的任务之间在共享一个资源时，就可能发生优先级反转。当低优先级的任务获得了共享资源的锁时，该任务应该迅速完成，并释放掉锁，然后让高优先级的任务在没有明显的延时下继续执行。然而当低优先级阻塞着高优先级期间(低优先级获得的时间又比较少)，如果有一个中优先级的任务(该任务不需要那个共享资源)，那么可能会抢占低优先级任务，而被执行——因为此时高优先级任务是被阻塞的，所以中优先级任务是目前所有可运行任务中优先级最高的。此时，中优先级任务就会阻塞着低优先级任务，导致低优先级任务不能释放掉锁，也就会引起高优先级任务一直在等待锁的释放。
     
     priority-inversion@2x
     
     在我们的实际代码中，可能不会像火星探测器那样，遇到优先级反转时，不同的重启。
     
     解决这个问题的方法，通常就是不要使用不同的优先级——将高优先级的代码和低优先级的代码修改为相同的优先级。当使用GCD时，总是使用默认的优先级队列。如果使用不同的优先级，就可能会引发事故。
     
     虽然有些文章上说，在不同的队列中使用不同的优先级，这听起来不错，但是这回增加并发编程的复杂度和不可预见性。如果编程中，在高优先级任务中突然没有理由的卡住了，可能你会想起本文，以及称为优先级反转的问题，甚至还会想起美国宇航局的工程师也遇到这样的问题。
     */
    
}








@end
