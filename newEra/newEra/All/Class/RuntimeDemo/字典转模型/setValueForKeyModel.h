//
//  setValueForKeyModel.h
//  newEra
//
//  Created by lantian on 2017/7/14.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface setValueForKeyModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSNumber *phoneNumber;
@property (nonatomic, copy) NSNumber *height;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) setValueForKeyModel *son;
@end
