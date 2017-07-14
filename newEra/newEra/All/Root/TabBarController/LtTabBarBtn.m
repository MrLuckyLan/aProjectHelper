//
//  LtTabBarBtn
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技. All rights reserved.
//

#import "LtTabBarBtn.h"
#import "UIView+LTCategory.h"

@implementation LtTabBarBtn





- (void)setHighlighted:(BOOL)highlighted
{
    // 方法;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height *0.75;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = CGRectGetWidth(contentRect);
    CGFloat imageH = contentRect.size.height * 0.7;
    return CGRectMake(0, 0, imageW, imageH);
}






@end
