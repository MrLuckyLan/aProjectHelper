//
//  YDBaseSafeApi.m
//  YunDaApp
//
//  Created by luyakus on 16/11/7.
//  Copyright © 2016年 long1009. All rights reserved.
//

#import "YDBaseSafeApi.h"
@implementation NSObject (YDSafe)
- (id)yd_objectForKey:(id)aKey
{
//    NSAssert([self respondsToSelector:@selector(objectForKey:)]&&aKey, @"%s,%d,对象不是字典,或者key是空,再错打你哦",__func__,__LINE__);
    if ([self respondsToSelector:@selector(objectForKey:)]&&aKey)
    {
        return [self performSelector:@selector(objectForKey:) withObject:aKey];
    }
    return nil;
}
@end

@implementation NSArray (YDSafe)

- (id)yd_objectAtIndex:(NSUInteger)index
{
//    NSAssert(index < self.count, @"%s,%d,数组越界,再错打你哦",__func__,__LINE__);
    if (self.count > 0)
    {
        id obj = self[index < self.count ? index : self.count - 1];
        return obj;
    }
    return [NSNull null];
}

@end

@implementation NSMutableArray (YDSafe)

- (void)yd_addObject:(id)anObject
{
    NSAssert([self respondsToSelector:@selector(addObject:)], @"%s,%d,对象不是可变数组,再错打你哦",__func__,__LINE__);
    NSAssert(anObject, @"%s,%d,被添加的对象为空,再错打你哦",__func__,__LINE__);

    if ([self respondsToSelector:@selector(addObject:)] && anObject)
    {
        [self addObject:anObject];
    }
}
- (void)yd_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    NSAssert([self respondsToSelector:@selector(insertObject:atIndex:)], @"%s,%d,对象不是可变数组,再错打你哦",__func__,__LINE__);
    NSAssert(anObject, @"%s,%d,被添加的对象为空,再错打你哦",__func__,__LINE__);
    NSAssert(index <= self.count, @"%s,%d,数据越界啦,再错打你哦",__func__,__LINE__);
    if ([self respondsToSelector:@selector(insertObject:atIndex:)] && anObject && index <= self.count)
    {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)yd_removeObjectAtIndex:(NSUInteger)index
{
    NSAssert(index < self.count, @"%s,%d,数组越界,再错打你哦",__func__,__LINE__);
    [self removeObjectAtIndex:index];
}


@end
