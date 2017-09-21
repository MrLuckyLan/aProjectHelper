//
//  LtTabBarBtn
//
//  Created by lantian on 2015/5/6.
//  Copyright (c) 2015年 上海珺玥网络科技. All rights reserved.
//

#import "LtTabBarBtn.h"
#import "UIView+LTCategory.h"

@interface LtTabBarBtn ()

@property (nonatomic, strong) UIView *badge;
@property (nonatomic, strong) UILabel *badgeNum;

@end

@implementation LtTabBarBtn


- (void)badgeStyle:(badgeStyle)style
{
    switch (style) {
        case Normal_BadgeStyle:
            [self addSubview:self.badge];
            self.badge.hidden = YES;
            break;
        case Number_BadgeStyle:
            [self addSubview:self.badgeNum];
            self.badgeNum.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)badgeNormalShow:(BOOL)show
{
    [self addSubview:self.badge];
    self.badge.hidden = !show;
}

- (void)badgeNum:(int)num
{
    [self addSubview:self.badgeNum];
    self.badgeNum.text = [NSString stringWithFormat:@"%d", num];
    self.badgeNum.hidden = num == 0 ;
}



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

- (UIView *)badge
{
    if (!_badge) {
        _badge = [[UIView alloc] init];
        _badge.layer.cornerRadius = 3.5;
        _badge.layer.masksToBounds = YES;
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        _badge.frame = CGRectMake(w / 5.f - 30, 0, 7, 7);
        _badge.backgroundColor = [UIColor redColor];
    }
    return _badge;
}

- (UILabel *)badgeNum
{
    if (!_badgeNum) {
        _badgeNum = [[UILabel alloc] init];
        _badgeNum.layer.cornerRadius = 10;
        _badgeNum.layer.masksToBounds = YES;
        _badgeNum.textColor = [UIColor whiteColor];
        _badgeNum.font = [UIFont systemFontOfSize:9.f];
        _badgeNum.textAlignment = NSTextAlignmentCenter;
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        _badgeNum.frame = CGRectMake(w / 5.f - 30, 0, 20, 20);
        _badgeNum.backgroundColor = [UIColor redColor];
    }
    return _badgeNum;
}

-(void)commonInit{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
//    self.badge.frame = CGRectMake(w / 5.f - 30, 0, 10, 10);
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
