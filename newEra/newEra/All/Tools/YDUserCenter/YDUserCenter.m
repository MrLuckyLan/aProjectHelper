//
//  YDUserConfig.m
//  YunDaApp
//
//  Created by long1009 on 16/9/9.
//  Copyright © 2016年 long1009. All rights reserved.
//
#import "YDUserCenter.h"
#import <objc/runtime.h>
#import "YDBaseSafeApi.h"



@implementation YDUser


- (id) valueForUndefinedKey:(NSString *)key
{
    return @"";
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSString *error = [NSString stringWithFormat:@"设置了不存在的key = %@",key];
    NSAssert(nil, error);
    NSLog(@"操作不成功,error = %@",error);
}
+ (NSArray *)getSelfProperty
{
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }

    return mArray.copy;
    
}
@end


// 最后登录用户
//NSString * const YD_LastUser = @"YD_LastUser";
// 登录过的用户名单
NSString * const YD_UserList = @"YD_UserList";


static YDUser *currentUser = nil;

@implementation YDUserCenter

- (instancetype)init
{
    return nil;
}


+ (YDUser *)currentUser
{
    if (!currentUser)
    {
        currentUser = nil;
        NSArray *tempUsers = [self getAllUsers];
        if (0 != tempUsers.count) {
            currentUser = [self getLastUser];
        }else {
            currentUser = [[YDUser alloc] init];
        }
    }
    return currentUser;
}

+ (YDUser *)getLastUser {
    NSArray *accouts = [[NSUserDefaults standardUserDefaults] objectForKey:YD_UserList];
    if (0 == accouts.count) {
        return [[YDUser alloc] init];
    }
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:accouts.firstObject];
    YDUser *user = [[YDUser alloc] init];
    [user setValuesForKeysWithDictionary:userDic];
    return user;
}

// 退出账号但是不清空用户信息 : 多账号时使用
+ (void)quitCurrentUser
{
    currentUser.isLogin = NO;
    currentUser.avatar = nil;
    [self synchronize];
}

// 退出并清空用户数据
+ (void)clearCurrentUser
{
    // 删除当前用户
    [self clearUserByAccout:currentUser.account_id];
    // 获取新的用户信息
    currentUser = [self getLastUser];
}
// 删除当前用户信息
+ (void)clearUserByAccout:(NSString *)account
{
    NSString *error = [NSString stringWithFormat:@"该用户账号为空,%s",__func__];
    if (!(account && account.length != 0))
    {
        NSAssert(nil,error);
        NSLog(@"操作不成功,error = %@",error);
        return;
    }
    NSMutableArray *userList = nil;
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:YD_UserList] isKindOfClass:[NSArray class]])
    {
        userList = [[NSMutableArray alloc] init];
    }
    else
    {
        userList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:YD_UserList]];
    }
    if (![userList containsObject:account])
    {
        NSString *error = [NSString stringWithFormat:@"不存在该账号,%s",__func__];
        NSAssert(nil,error);
        NSLog(@"操作不成功,error = %@",error);
        return;
    }
    [userList removeObject:account];
    
    [[NSUserDefaults standardUserDefaults] setObject:userList forKey:YD_UserList];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:account];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (NSArray <YDUser *> *)getAllUsers
{
    NSMutableArray *userList = nil;
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:YD_UserList] isKindOfClass:[NSArray class]])
    {
        userList = [[NSMutableArray alloc] init];
    }
    else
    {
        userList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:YD_UserList]];
    }
   
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < userList.count; i ++)
    {
        NSString *userAccout = [userList yd_objectAtIndex:i];
        NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:userAccout];
        YDUser *user = [[YDUser alloc] init];
        [user setValuesForKeysWithDictionary:userInfo];
        [userArray  addObject:user];
    }
    return userArray;
}
+ (void)synchronize
{
    NSString *error = [NSString stringWithFormat:@"该用户账号为空,%s",__func__];
    if (!(currentUser && currentUser.account_id && currentUser.account_id.length != 0))
    {
        NSAssert(nil,error);
        NSLog(@"操作不成功,error = %@",error);
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[self currentUserInfo] forKey:currentUser.account_id];

    NSMutableArray *userList = nil;
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:YD_UserList] isKindOfClass:[NSArray class]])
    {
        userList = [[NSMutableArray alloc] init];
    }
    else
    {
        userList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:YD_UserList]];
    }
    
    // 值的对比不能用contain
    __block NSInteger index = -1;
    [userList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:currentUser.account_id]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (-1 != index)
    {
        [userList removeObjectAtIndex:index];
    }
    [userList insertObject:currentUser.account_id atIndex:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:userList forKey:YD_UserList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)currentUserInfo
{
    NSArray *properties = [YDUser getSelfProperty];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *propertyName in properties)
    {
        [dic setValue:[currentUser valueForKey:propertyName]?:@"" forKey:propertyName];
    }
    return dic;
}




@end
