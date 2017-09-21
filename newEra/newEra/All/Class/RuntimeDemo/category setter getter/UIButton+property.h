//
//  UIButton+property.h
//  newEra
//
//  Created by lantian on 2017/7/14.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIButtonProperty)();

@interface UIButton (property)



@property (nonatomic,copy) UIButtonProperty touch;



@end
