//
//  URLConstant.m
//  newEra
//
//  Created by lantian on 2017/7/11.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "Config.h"
#import "URLConstant.h"


#if ENVIRONMENT == 0

NSString *const API_DNS = @"API_DNS开发环境 000000";

#elif ENVIRONMENT ==1

NSString *const API_DNS = @"API_DNS测试环境 111111";

#elif ENVIRONMENT ==2

NSString *const API_DNS = @"API_DNS正式环境 222222";

#else

NSString *const API_DNS = @"'ENVIRONMENT 其他";

#endif





// 获取订单列表
NSString * const API_LogIn = @"loginloginlogin";


















