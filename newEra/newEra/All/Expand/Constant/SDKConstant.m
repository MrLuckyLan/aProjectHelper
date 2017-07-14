//
//  SDKConstant.m
//  newEra
//
//  Created by lantian on 2017/7/11.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "SDKConstant.h"
#import "Config.h"







#if ENVIRONMENT == 0

NSString *const AliPayKey = @"'AliPayKeyENVIRONMENT 0000000";
NSString *const WechatKey = @"'WechatKeyENVIRONMENT 0000000";


#elif ENVIRONMENT ==1

NSString *const AliPayKey = @"'AliPayKeyENVIRONMENT 1111111";
NSString *const WechatKey = @"'WechatKeyENVIRONMENT 1111111";

#elif ENVIRONMENT ==2


NSString *const AliPayKey = @"'AliPayKeyENVIRONMENT 2222222";
NSString *const WechatKey = @"'WechatKeyENVIRONMENT 2222222";


#else








#endif

