//
//  FreeUIBtn.h
//  newEra
//
//  Created by lantian on 2017/7/7.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FreeUIBtn_Type) {
    FreeUIBtn_Type_IMGUP = 1,
    FreeUIBtn_Type_IMGLEFT,
    FreeUIBtn_Type_IMGRIGHT,
};

@interface FreeUIBtn : UIButton

- (instancetype)initWithFrame:(CGRect)frame withIMG:(UIImage *)img title:(NSString *)title type:(FreeUIBtn_Type)type;

@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIImage *image;

@end
