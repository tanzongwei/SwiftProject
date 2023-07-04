//
//  NSString+BAEncrypt.h
//  BeautyAccountDemo
//
//  Created by Aokura on 2017/11/8.
//  Copyright © 2017年 Beauty,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

// URLEncode编码
- (NSString *)ba_urlEncode;

// SHA256加密
- (NSString *)ba_sha256;

// AES-128加密,作用于手机
- (NSString *)ba_aes128String;
- (NSString *)ba_aes128Decrypt;

// MD5加密
- (NSString *)ba_md5;

// 验证密码是否符合规则
- (BOOL)ba_validatePassword;

@end
