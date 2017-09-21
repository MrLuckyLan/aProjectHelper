//
//  NSString+LTCategory.h
//  newEra
//
//  Created by lantian on 2015/5/6.
//  Copyright © 2017年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (LTCategory)


- (BOOL)isNull;    // 验证是否为nil、length=0、（null）

#pragma mark - 校验
- (BOOL)isNumber;//全是数字
- (BOOL)isEnglishWords;//验证英文字母
- (BOOL) isOnlyChinese; //是否只有中文
- (BOOL)isValidatePassword; //验证密码：6—16位，只能包含字符、数字和 下划线。
- (BOOL) isOnlyNumber;//限制只能输入数字
- (BOOL) isValidRealName; //有效的真实姓名
- (BOOL) isValidMobileNumber; //有效的电话号码
- (BOOL) isValidVerifyCode; //有效的验证码(根据自家的验证码位数进行修改
- (BOOL) isValidBankCardNumber; //有效的银行卡号
- (BOOL) isValidEmail; //有效的邮箱
- (BOOL) isValidAlphaNumberPassword; //有效的字母数字密码
- (BOOL) isValidIdentifyFifteen;//15位 检测有效身份证
- (BOOL) isValidIdentifyEighteen;//18位 检测有效身份证
+ (BOOL)isIdentityCardWithString:(NSString *)valu; // 身份证校验

#pragma mark - 加密
- (NSString *) md5;//MD5加密
+(NSString *)MD5ForLower32Bate:(NSString *)str; // MD5加密, 32位 小写
+(NSString *)MD5ForUpper32Bate:(NSString *)str; //MD5加密, 32位 大写
+(NSString *)MD5ForLower16Bate:(NSString *)str; //MD5加密, 16位 小写
+(NSString *)MD5ForUpper16Bate:(NSString *)str; //MD5加密, 16位 大写
+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length; //Data类型转换为Base64

#pragma mark - 字符串处理
- (CGFloat)heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width; //计算文字高度
+ (NSString*) getSecrectStringWithPhoneNumber:(NSString*)phoneNum; //电话号码中间4位****显示
+ (NSString*) getSecrectStringWithAccountNo:(NSString*)accountNo; //银行卡号中间8位显示


/**
 *  字符串添加图片
 */
-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect;
/**
 *  不同颜色不同字体大小字符串
 */
-(NSMutableAttributedString *)setOtherColor:(UIColor *)Color font:(CGFloat)font forStr:(NSString *)forStr;













@end
