//
//  UIImageView+toBig.m
//  测试UI
//
//  Created by 夏东健 on 2017/3/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+LTCategory.h"
#import "UIImageView+toBig.h"


#import <objc/runtime.h>



#define SCREEN_WIDTH_ANIMATIONVIEW [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_ANIMATIONVIEW [UIScreen mainScreen].bounds.size.height

@interface UIImageView () <UIScrollViewDelegate>

@property (nonatomic ,strong)UIImageView *imageV;
//当前是否已经处于动画状态
@property (nonatomic ,assign)BOOL imageViewIsStateAnimation;

@end

@implementation UIImageView (toBig)

- (void)canToBigImageViewWithWindow
{
    self.imageViewIsStateAnimation = NO;
    UITapGestureRecognizer *toBig = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToBig:)];
    self.userInteractionEnabled = YES;
    
    [self addGestureRecognizer:toBig];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

//点击放大
- (void)ToBig:(UITapGestureRecognizer *)tap
{
    
    if (self.imageViewIsStateAnimation == NO) {
        
        //取到window
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //背景View
        UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [window addSubview:backView];
        
        //利用 UIScrollView 自带的可缩放属性做图片的捏合效果
        UIScrollView *imageBackView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_ANIMATIONVIEW, SCREEN_HEIGHT_ANIMATIONVIEW)];
        imageBackView.canCancelContentTouches = YES;
        imageBackView.maximumZoomScale = 2.0; //最大倍率
        imageBackView.minimumZoomScale = 1.0; //最小倍率
        imageBackView.decelerationRate = 1.0; //减速倍率
        imageBackView.delegate = self;
        imageBackView.showsVerticalScrollIndicator = NO;
        imageBackView.showsHorizontalScrollIndicator = NO;
        imageBackView.contentSize = CGSizeMake(SCREEN_WIDTH_ANIMATIONVIEW, SCREEN_HEIGHT_ANIMATIONVIEW);
        //imageBackView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [backView addSubview:imageBackView];
        
        
        
        CGFloat imageW = self.image.size.width;
        CGFloat imageH = self.image.size.height;
        CGFloat scale = imageW / imageH;
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT_ANIMATIONVIEW - SCREEN_WIDTH_ANIMATIONVIEW / scale)/2,SCREEN_WIDTH_ANIMATIONVIEW, SCREEN_WIDTH_ANIMATIONVIEW / scale)];
        self.imageV.image = self.image;
        //self.imageV.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [imageBackView addSubview:self.imageV];
        
        //添加一个类似导航栏的View
        UIView *navcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_ANIMATIONVIEW, 64)];
        navcView.backgroundColor = [UIColor blueColor];
        [backView addSubview:navcView];
        
        //左侧关闭按钮
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
        leftBtn.frame = CGRectMake(5, 0 ,80, 34);
        leftBtn.centerY = navcView.centerY + 10;
        [leftBtn addTarget:self action:@selector(CloseAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [navcView addSubview:leftBtn];
        
        
        UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        RightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [RightBtn setTitle:@"保存图片" forState:UIControlStateNormal];
        RightBtn.frame = CGRectMake(SCREEN_WIDTH_ANIMATIONVIEW - 85 , 0, 80, 34);
        RightBtn.centerY = navcView.centerY + 10;
        [RightBtn addTarget:self action:@selector(SaveImage:) forControlEvents:UIControlEventTouchUpInside];
        [navcView addSubview:RightBtn];
        
        [self showAnimationWithView:backView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageV;
}


//让 contentSize 适应图片的变化，不至于变得过大或过小
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGSize ViewSize = view.frame.size;
    //CGFloat changeSizeWidth = ViewSize.width - ViewSize.width / scale;//宽度发生变化的值
    CGFloat changeSizeHeight = ViewSize.height - ViewSize.height / scale;//高度发生变化的值
    scrollView.contentSize = CGSizeMake(ViewSize.width, SCREEN_HEIGHT_ANIMATIONVIEW + changeSizeHeight);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%f",scrollView.contentOffset.y);
}


- (void)showAnimationWithView:(UIView *)animationView{
    animationView.alpha = 0;
    CGFloat d1 = 0.2, d2 = 0.15;
    animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:d1 animations:^{
        animationView.alpha = 1;
        animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:d2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.alpha = 1;
            animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished2) {
            self.imageViewIsStateAnimation = YES;
        }];
    }];
}

- (void)hideAnimationWithView:(UIView *)animationView{
    
    CGFloat d1 = 0.2, d2 = 0.1;
    [UIView animateWithDuration:d2 animations:^{
        animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:d1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.alpha = 0;
            animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        } completion:^(BOOL finished2){
            //动画完成删除View
            [animationView removeFromSuperview];
            //更新状态以备下次点击放大
            self.imageViewIsStateAnimation = NO;
        }];
    }];
}




#pragma mark-----点击关闭按钮
- (void)CloseAnimation:(UIButton *)btn
{
    //取到背景黑色View
    UIView *backView = [[btn superview] superview];
    [self hideAnimationWithView:backView];
    
    if ([self.toBigImageVdelegate respondsToSelector:@selector(PressBtn)]) {
        [self.toBigImageVdelegate PressBtn];
    }
    
}

#pragma mark-----点击保存图片按钮
- (void)SaveImage:(UIButton *)btn
{
    
    UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

#pragma mark-----保存图片指定回调方法
- (void)image:(UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark------setter and getter
- (UIImageView *)imageV
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageV:(UIImageView *)imageV
{
    objc_setAssociatedObject(self, @selector(imageV) ,imageV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)imageViewIsStateAnimation
{
    return [objc_getAssociatedObject(self, _cmd ) boolValue];
}

- (void)setImageViewIsStateAnimation:(BOOL)imageViewIsStateAnimation
{
    objc_setAssociatedObject(self, @selector(imageViewIsStateAnimation),@(imageViewIsStateAnimation), OBJC_ASSOCIATION_RETAIN);
}

- (id<ToBigImageViewDelegate>)toBigImageVdelegate
{
    return objc_getAssociatedObject(self, _cmd );
}

- (void)setToBigImageVdelegate:(id<ToBigImageViewDelegate>)toBigImageVdelegate
{
    objc_setAssociatedObject(self, @selector(toBigImageVdelegate),toBigImageVdelegate, OBJC_ASSOCIATION_ASSIGN);
}



@end
