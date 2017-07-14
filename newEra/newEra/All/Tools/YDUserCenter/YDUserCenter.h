//
//  YDUserConfig.h
//  YunDaApp
//
//  Created by long1009 on 16/9/9.
//  Copyright © 2016年 long1009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface YDUser : NSObject

@property (nonatomic, copy) NSString *account_id;//// 账户

@property (nonatomic, copy) NSString *token;// 令牌
@property (nonatomic, copy) NSString *publicKey;// 公钥
@property (nonatomic,copy) NSString *openid;

// data
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *rank;//级别
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *avatar; // 头像链接
@property (nonatomic,copy) NSString *uuid;

@property (nonatomic,copy) NSString *mobile;

@property (nonatomic, assign) BOOL isLogin;
@end


@interface YDUserCenter : NSObject

#pragma mark - 单用户API

// 上个登录的用户
+ (YDUser *)getLastUser;
// 当前用户
+ (YDUser *)currentUser;
// 同步用户,对当前用户信息修改后要执行同步操作
+ (void)synchronize;
// 退出并清空用户数据
+ (void)clearCurrentUser;
// 退出账号但是不清空用户信息 : 多账号时使用
+ (void)quitCurrentUser;


#pragma mark - 多用户API

+ (NSArray <YDUser *> *)getAllUsers;
+ (void)clearUserByAccout:(NSString *)account;




@end
