//
//  UIAlertView+LTCategory.m
//  newEra
//
//  Created by lantian on 2017/7/12.
//  Copyright © 2017年 LT. All rights reserved.
//

#import "UIAlertView+LTCategory.h"

#import <objc/runtime.h>

typedef void(^Confirm)();
typedef void(^Cancel)();
static const void *UIAlertViewOriginalDelegateKey                = &UIAlertViewOriginalDelegateKey;
static const void *UIAlertViewCancelBlockKey                     = &UIAlertViewCancelBlockKey;
static const void *UIAlertViewSubmitBlockKey                     = &UIAlertViewSubmitBlockKey;

@implementation UIAlertView (LTCategory)







+ (instancetype)alertWithTitle:(NSString *)title messgae:(NSString *)messgae cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void (^)())cancel confirm:(void (^)())confirm{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:messgae delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:confirmTitle, nil];
    
    if (confirm) {
        [alert setDidConfirmBlock:confirm];
    }
    if (cancel) {
        [alert setCancelBlock:cancel];
    }
    return alert;
}

- (void)setDidConfirmBlock:(Confirm)didPresentBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewSubmitBlockKey, didPresentBlock, OBJC_ASSOCIATION_COPY);
}
- (Confirm)didConfirmBlock {
    return objc_getAssociatedObject(self, UIAlertViewSubmitBlockKey);
}

- (void)setCancelBlock:(Cancel)cancelBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY);
}
- (Cancel)cancelBlock {
    return objc_getAssociatedObject(self, UIAlertViewCancelBlockKey);
}
- (void)_checkAlertViewDelegate {
    if (self.delegate != (id<UIAlertViewDelegate>)self) {
        objc_setAssociatedObject(self, UIAlertViewOriginalDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UIAlertViewDelegate>)self;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            Cancel cancel = [alertView cancelBlock];
            cancel();
        }
            break;
        case 1:
        {
            Confirm confirm = [alertView didConfirmBlock];
            confirm();
        }
            break;
        default:
            break;
    }
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}











@end
