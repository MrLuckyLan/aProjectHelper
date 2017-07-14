//
//  UIImage+LTCategory.h
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LTCategory)

/**
 *  按照size缩放 处理速度快
 *
 *  @param sourceImage 要处理的照片
 *
 *  @param fixedWidth 按照宽度等比例压缩(一般通用处理为屏幕宽)
 *
 * @param scale 按比例压缩 取值(0~1) PS:压缩优先选择参数fixedWidth,fixedWidth若有值scale并没用
 *
 *  @return self-->(image)
 */
+ (UIImage *)zipEasyFuncImage:(UIImage *)sourceImage ByFixedWidth:(CGFloat)fixedWidth OrScale:(CGFloat)scale;




/**
 将图片压缩到指定的KB
 
 @param image image
 @return Data
 */
+ (NSData *)zipDataImage:(UIImage *)image ToKB:(NSInteger)kb;

/**
 *  改变图片的size
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)zipSizeImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;


/**
 *  抓取屏幕。
 *  @param  scale 屏幕放大倍数，1为原尺寸。
 *  return  屏幕后的Image。
 */
+ (UIImage *)grabScreenWithScale:(CGFloat)scale;

/**
 *  抓取UIView及其子类。
 *  @param  view UIView及其子类。
 *  @param  scale 屏幕放大倍数，1为原尺寸。
 *  return  抓取图片后的Image。
 */
+ (UIImage *)grabImageWithView:(UIView *)view scale:(CGFloat)scale;



/**
 *  自由改变Image的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)cropImageWithSize:(CGSize)size;


/**
 *  根据图片返回一张高斯模糊的图片
 *
 *  @param blur 模糊系数
 *
 *  @return 新的图片
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;




/**图片添加"图片"水印  rect*/
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;


/** 图片添加文字水印 inRect*/
- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;

/** 图片添加文字水印 atPoint*/
- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;



/**取图片某一点的颜色*/
- (UIColor *)colorAtPoint:(CGPoint )point;


/** 取某一像素的颜色*/
- (UIColor *)colorAtPixel:(CGPoint)point; //more accurate method ,colorAtPixel 1x1 pixel

/**获得灰度图*/
+ (UIImage*)covertToGrayImageFromImage:(UIImage*)sourceImage;

/* 裁剪圆形图片 例如：头像 */
+ (UIImage *)clipImage:(UIImage *)image;



@end
