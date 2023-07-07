//
//  MCLoginNumberCheckTool.h
//  MCLoginProcess
//
//  Created by liaozq on 2018/9/10.
//

#import <Foundation/Foundation.h>

@interface TZWLoginNumberCheckTool : NSObject

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码8-20位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

#pragma 是否包含空格
/// 是否包含空格
+ (BOOL)checkHasSpace:(NSString *)string;

#pragma 生成区号
+ (NSNumber *)createAreaCode:(NSString *)code;

#pragma 判断字符串中是否存在emoji
+ (BOOL)stringContainsEmoji:(NSString *)string;

#pragma 判断字符串中是否存在emoji 限制第三方键盘
+ (BOOL)hasEmoji:(NSString*)string;

#pragma 判断是不是九宫格
+ (BOOL)isNineKeyBoard:(NSString *)string;

#pragma mark  过滤字符串中的emoji
- (NSString *)disable_emoji:(NSString *)text;

#pragma mark 判断 字母、数字、中文
- (BOOL)isInputRuleAndNumber:(NSString *)str;

@end
