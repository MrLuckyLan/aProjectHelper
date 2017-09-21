//
//  YDBaseSafeApi.h
//  YunDaApp
//
//  Created by luyakus on 16/11/7.
//  Copyright © 2016年 long1009. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSObject(YDSafe)
- (nullable id)yd_objectForKey:(nonnull id)aKey;
@end

@interface NSArray (YDSafe)
/**
 *  不越界正常取值,越界去最后一个
 */
- (nullable id)yd_objectAtIndex:(NSUInteger)index;
@end

@interface NSMutableArray (YDSafe)
- (void)yd_addObject:(nonnull id)anObject;
- (void)yd_removeObjectAtIndex:(NSUInteger)index;
- (void)yd_insertObject:(nonnull id)anObject atIndex:(NSUInteger)index;
@end
