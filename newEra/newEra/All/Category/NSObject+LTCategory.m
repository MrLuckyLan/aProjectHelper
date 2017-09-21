//
//  NSObject+LTCategory.m
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+LTCategory.h"

#define kAppStoreVersionKey @"1.0.0"

@implementation NSObject (LTCategory)




- (BOOL)isExist
{
    if (nil == self)
    {
        return NO;
    }
    
    if ([NSNull null] == self)
    {
        return NO;
    }
    
    
    if ([self isKindOfClass:[NSString class]])
    {
        NSString *tempStr = (NSString *)self;
        if ((tempStr.length < 1) || [tempStr isEqualToString:@" "] || [tempStr isEqualToString:@"null"] || [tempStr isEqualToString:@"(null)"] || [tempStr isEqualToString:@"<null>"])
        {
            return NO;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]])
    {
        NSArray *tempArr = (NSArray *)self;
        if (!(tempArr.count > 0))
        {
            return NO;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *tempDic = (NSDictionary *)self;
        if (!(tempDic.count > 0))
        {
            return NO;
        }
    }
    
    
    return YES;
    
}



#pragma mark - 获取JSON数据
// 把对象转换成JSON格式数据，如果转换失败，返回nil
+ (NSMutableData *)JSONDataWithObject:(id)object {
    NSMutableData *postBodyData = nil;
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (error) {
            NSLog(@"error: %@", error.description);
        } else {
            postBodyData = [[NSMutableData alloc] initWithData:postData];
        }
    }
    return postBodyData;
}

#pragma mark - 获取最新版本
+ (NSString *)obtainLatestAppVersion {
    // NSString *urlPath = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", kAppIDInAppStore];
    NSString *latestVersion = nil;
    NSDictionary *jsonData = nil; // 这里需要从网络请求到，这里只是写成nil，在发布后再实现
    NSArray *infoArray = [jsonData objectForKey:@"results"];
    if([infoArray count] > 0) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        latestVersion = [releaseInfo objectForKey:@"version"];
        
        // 在以前返回的值是如下格式："4.0"，后来变成了："V4.0",所以需要去掉非数值字符。
        latestVersion = [latestVersion stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
    }
    
    return latestVersion;
}

#pragma mark - 保存应用在AppStore上的版本号到本地
+ (void)saveAppStoreVersionToUserDefaults {
    NSString *storeVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kAppStoreVersionKey];
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    // 应用当前的version，应该小于等于store上的version。如果不是，则说明应用升级后，
    // UserDefault中保存的store version未更新，需重新设。
    if(nil == storeVersion || [self version:bundleVersion isBiggerThan:storeVersion]) {
        storeVersion = [self obtainLatestAppVersion]; // 获取最新的版本
        if (storeVersion) {
            [[NSUserDefaults standardUserDefaults] setObject:storeVersion forKey:kAppStoreVersionKey];
        }
    }
    return;
}

#pragma mark - 是否需要更新应用
+ (BOOL)isAppNeedToUpdate:(BOOL)needNetwork {
    NSString *version = nil;
    if (needNetwork) { // 获取应用在appStore上的版本
        version = [self obtainLatestAppVersion];
        if (version) { // 保存到本地
            [[NSUserDefaults standardUserDefaults] setObject:version forKey:kAppStoreVersionKey];
        }
    } else { // 直接从本地获取
        version = [[NSUserDefaults standardUserDefaults] stringForKey:kAppStoreVersionKey];
    }
    
    if (!version) {
        return NO;
    }
    
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if ([self version:version isBiggerThan:bundleVersion]) {
        return YES;
    }
    return NO;
}

+ (BOOL)version:(NSString *)versionA isBiggerThan:(NSString *)versionB {
    NSArray *a = [versionA componentsSeparatedByString:@"."];
    NSArray *b = [versionB componentsSeparatedByString:@"."];
    
    unsigned aa = [[a objectAtIndex:0] intValue];
    unsigned ab = [a count] > 1 ? [[a objectAtIndex:1] intValue] : 0;
    unsigned cc = [a count] > 2 ? [[a objectAtIndex:2] intValue] : 0;
    
    unsigned ba = [[b objectAtIndex:0] intValue];
    unsigned bb = [b count] > 1 ? [[b objectAtIndex:1] intValue] : 0;
    unsigned bc = [b count] > 2 ? [[b objectAtIndex:2] intValue] : 0;
    
    return ((aa > ba) || (aa == ba && ab > bb) || (aa == ba && ab == bb && cc > bc));
}

// 参数是要判断的应用的URLSchemes
+ (BOOL)hadInstallApp:(NSString *)urlSchemes {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlSchemes]]) {
        return YES;
    }
    return NO;
}

// 能否打开应用
+ (BOOL)canOpenApp:(NSString *)itunesUrlString {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:itunesUrlString]]) {
        return YES;
    }
    return NO;
}

+ (void)openApp:(NSString *)urlSchemes {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlSchemes]];
    return;
}

#pragma mark - 进入AppStore应用
+ (void)goToAppStoreWithURLString:(NSString *)itunesUrlString {
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"虚拟机不支持APP Store.打开iTunes不会有效果。");
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesUrlString]];
#endif
    return;
}






@end
