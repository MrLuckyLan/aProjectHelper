//
//  RunTimeController.m
//  newEra
//
//  Created by lantian on 2017/7/13.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "AllHeader.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "RunTimeTestOne.h"
#import "RunTimeController.h"
#import "RunTimeTestTwo.h"
#import "LoadModel.h"
#import "UIImage+replaceSystem.h"
#import "replaceView.h"
#import "UIButton+property.h"
#import "setValueForKeyModel.h"
#import "NSObject+setValueForKey.h"
#import "RuntimeArchiveModel.h"


@interface RunTimeController (){
    NSDictionary *data;
}

@end

@implementation RunTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}





// 解归档
- (IBAction)test6:(id)sender {
    
    RuntimeArchiveModel *model = [RuntimeArchiveModel objectWithKeyValues:data];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"test"];
    [NSKeyedArchiver archiveRootObject:model toFile:path];
    
    RuntimeArchiveModel *m = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"m.name is %@",m.name);
    NSLog(@"m.son name is %@",m.son.name);
}

// 字典转模型
- (IBAction)test5:(UIButton *)sender {
    
    setValueForKeyModel *obj = [setValueForKeyModel objectWithKeyValues:data];
    NSLog(@"%@", obj);
    NSDictionary *dic = [obj keyValuesWithObject];
    NSLog(@"%@", dic);
}


// category 添加 setter getter
- (IBAction)test4:(UIButton *)sender {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.view.bounds;
    button.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:button];
    __weak __typeof(&*button)weakBtn = button;
    
    button.touch = ^{
        [weakBtn removeFromSuperview];
        NSLog(@"buttonClicked");
    };
    
}

// 替换系统方法
- (IBAction)test3:(UIButton *)sender {
    
    // 普通方法
    [UIImage imageNamed:@"unknown.jpg"];
    // 严谨的方法
    [replaceView setAnimationsEnabled:YES];
}

#pragma mark - 动态方法解析,方法替换,动态添加方法,处理找不到方法

- (IBAction)test2:(UIButton *)sender {
    
    /*================   type 0   消息决议过程       =================
     
     =================   type 1   添加,绑定新方法   =================
     1.(RunTimeTestOne *) objnew 执行一个不存在的 sayHello 方法,
        注 : 下面的sayHello 并不是RunTimeTestOne的方法
     2. 在 RunTimeController 中查找一个 flyhere 的方法
     3. 添加了  RunTimeController 中的 flyhere 方法
     
     =================   type 2   方法的替换            =================*/

    
    int type = 0;
    
    if (0 == type)
    {
        RunTimeTestTwo *obj = [[RunTimeTestTwo alloc] init];
        ((void (*) (id, SEL)) objc_msgSend) (obj, sel_registerName("fly"));
    }
    else if (1 == type)
    {
        RunTimeTestOne *objnew = [RunTimeTestOne new];
        class_addMethod([RunTimeTestOne class], @selector(sayHello), class_getMethodImplementation([RunTimeController class], @selector(flyhere)), "v@:");
        [objnew performSelector:@selector(sayHello)];
    }
    else if (2 == type)
    {
        //获取实例对象方法
        //获取类方法:class_getClassMethod
//        RunTimeTestOne *o1 = [RunTimeTestOne new];
//        RunTimeTestTwo *o2 = [RunTimeTestTwo new];
//        Method m1 = class_getInstanceMethod([RunTimeTestOne class], @selector(funco1));
//        Method m2 = class_getInstanceMethod([RunTimeTestTwo class], @selector(funco2));
//        method_exchangeImplementations(m1, m2);
//        [o1 funco1]; // 去 RunTimeTestOne.h 中暴露 funco1 方法
//        [o2 funco2]; // 去 RunTimeTestTwo.h 中暴露 funco1 方法
    }
}

// ↓↓↓↓↓↓ flyhere 方法
- (void)flyhere
{
    NSLog(@"flyhere let me  fly");
}

- (void)sayHello
{
    NSLog(@"不会执行这段代码, 因为 [RunTimeTestOne class] 中没有此代码");
}


#pragma mark - objc_msgSend使用

/**
 objc_msgSend

 @param sender 获取方法,并调用方法.获取方法列表
 */
- (IBAction)test1:(UIButton *)sender {
    RunTimeTestOne *obj = [RunTimeTestOne new];
    //    NSLog(@"%s", object_getClassName(obj));
    
    // 无参数无返回
    ((void (*) (id, SEL)) objc_msgSend) (obj, sel_registerName("noReturnNoParameter"));
    // 有参数无返回
    ((void (*) (id, SEL, NSString *)) objc_msgSend) (obj, sel_registerName("noReturnHaveParameter:"), @"param");
    // 有参数有返回
    NSString *f = ((NSString *(*) (id, SEL, NSString *)) objc_msgSend) (obj, sel_registerName("haveReturnHaveParameter:"), @"param");
    NSLog(@"============%@===========", f);
    
    // 获取方法列表
    unsigned int count;
    Method *methods = class_copyMethodList([obj class], &count);
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        NSLog(@"%u : %@",count + 1,name);
        if (name)
        {
            
        }
    }
}




- (IBAction)test7:(UIButton *)sender {
    
    [LoadModel new];
    
    
    
    
    /*
     load
     
     顾名思义，load方法在这个文件被程序装载时调用。
     只要是在Compile Sources中出现的文件总是会被装载
     这与这个类是否被用到无关，因此load方法总是在main函数之前调用。切只调用一次
     
     顺序
     super  load
     sub  load
     Category  load
     
     
     如果一个类没有实现load方法，就不会调用它父类的load方法，
     这一点与正常的类继承和方法调用不一样，需要额外注意一下。
     
     特别注意点:
     1.load方法调用时，系统处于脆弱状态，如果调用别的类的方法，且该方法依赖于那个类的load方法进行初始化设置，
        那么必须确保那个类的load方法已经调用了
     2.load方法是线程安全的，它内部使用了锁，所以我们应该避免线程阻塞在load方法中。
     
     */
    
    
    
    
    
    /*
    initialize
     
     与load方法类似的是，在initialize方法内部也会调用父类的方法，
     而且不需要我们显示的写出来。与load方法不同之处在于，
     即使子类没有实现initialize方法，也会调用父类的方法，
     这会导致一个很严重的问题：
     super的initialize 会执行两次
     
     这是因为在创建子类对象时，首先要创建父类对象，所以会调用一次父类的initialize方法，
     然后创建子类时，尽管自己没有实现initialize方法，但还是会调用到父类的方法。
     
     // In Super.m
     + (void)initialize {
     if (self == [Super class]) {
       NSLog(@"Initialize Parent, caller Class %@", [self class]);
       }
     }
     
     
     
    先调用Super  的 initialize (Super 则***只***调用自己的SuperCategory initialize)
    再调用 自身的 initialize (若有自己的subCategory  则***只***调用subCategory initialize)
     
     */
    
    
    /**
     不同点 : 
     load  不实现自身的load 不会调用 super 的 load
     initialize 不实现自己的initialize 也会调用super 的 initialize  而导致  super的initialize 会执行两次
     
     */
    
    
}



- (void)loadData
{
    data = @{
             @"name":@"Dave Ping",
             @"age":@24,
             @"phoneNumber":@18718871111,
             @"height":@180.5,
             @"info":@{
                     @"address":@"Guangzhou",
                     },
             @"son":@{
                     @"name":@"Jack",
                     @"info":@{
                             @"address":@"London",
                             },
                     }
             };;
}








@end
