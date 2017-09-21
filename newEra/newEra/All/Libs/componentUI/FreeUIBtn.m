//
//  FreeUIBtn.m
//  newEra
//
//  Created by lantian on 2017/7/7.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "FreeUIBtn.h"
#import "UIView+LTCategory.h"

#define BtnImageRatio 0.6

@interface FreeUIBtn ()
{
    UIImage *_img;
    FreeUIBtn_Type _type;
}

@end

@implementation FreeUIBtn

- (instancetype)initWithFrame:(CGRect)frame withIMG:(UIImage *)img title:(NSString *)title type:(FreeUIBtn_Type)type
{
    if (self = [super initWithFrame:frame]) {
        
        _img = img;
        _type = type;
        
        [self setImage:img forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    }
    return self;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    _img = image;
    [self setImage:image forState:UIControlStateNormal];
    [self setNeedsLayout];
}
-(void)setFont:(UIFont *)font
{
    _font = font;
    self.titleLabel.font = font;
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat width = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width + _img.size.width + 10;
    CGFloat width =  [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width + _img.size.width + 10;
    CGRect newFrame = CGRectNull;
    
    
    switch (_type) {
        case 1:
            
            newFrame = self.frame;
            
            break;
        case 2:
            
            newFrame = CGRectMake(self.x, self.y, width, self.height);
            
            break;
        case 3:
            
            newFrame = CGRectMake(self.x, self.y, width, self.height);
            
            break;
            
        default:
            break;
    }
    
    self.frame = newFrame;
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectNull;
    switch (_type) {
        case 1:
        {
            CGFloat imageW = contentRect.size.width;
            CGFloat imageH = contentRect.size.height * BtnImageRatio;
            rect = CGRectMake(0, 0, imageW, imageH);
        }
            break;
        case 2:
        {
            CGFloat imageW = _img.size.width;
            CGFloat imageH = contentRect.size.height;
            rect = CGRectMake(0, 0, imageW, imageH);
        }
            
            break;
        case 3:
        {
            CGFloat imageW = _img.size.width;
            CGFloat imageH = contentRect.size.height;
            rect = CGRectMake(contentRect.size.width - imageW, 0, imageW, imageH);
        }
            
            break;
            
        default:
            break;
    }
    
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    
    
    CGRect rect = CGRectNull;
    switch (_type) {
        case 1:
        {
            CGFloat titleY = contentRect.size.height * BtnImageRatio;
            CGFloat titleW = contentRect.size.width;
            CGFloat titleH = contentRect.size.height - titleY;
            rect = CGRectMake(0, titleY, titleW, titleH);
        }
            break;
        case 2:
        {
            CGFloat imageW = _img.size.width;
            CGFloat titleW = contentRect.size.width - imageW;
            CGFloat titleH = contentRect.size.height;
            rect = CGRectMake(imageW, 0, titleW, titleH);
        }
            
            break;
        case 3:
        {
            CGFloat imageW = _img.size.width;
            CGFloat titleW = contentRect.size.width - imageW;
            CGFloat titleH = contentRect.size.height;
            rect = CGRectMake(0, 0, titleW, titleH);
        }
            
            break;
            
        default:
            break;
    }
    
    return rect;
}
@end
