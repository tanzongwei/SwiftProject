//
//  NSString+BAEncrypt.m
//  BeautyAccountDemo
//
//  Created by Aokura on 2017/11/8.
//  Copyright © 2017年 Beauty,Inc. All rights reserved.
//

#import "NSString+BAEncrypt.h"
#include <CommonCrypto/CommonCrypto.h>

static NSString * const sha256_seed = @"jc3mSBvkAdxV9KKVAw5G8dW38nFCGj";
static NSString * const aes128_seed = @"fdj!s#la$krdF3DG";

@implementation NSString (Encrypt)

- (NSString *)ba_urlEncode
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ~";
    
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    //%20为空格转出来的转义字符,这边需要转为+号丢给后台进行处理
    return [encodedString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
}

- (NSString *)ba_sha256
{
    const char *cKey  = [sha256_seed cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hmac = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [hmac base64EncodedStringWithOptions:0];
}

- (NSString *)ba_aes128String
{
    const char *string = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *stringdata = [[NSData alloc] initWithBytes:string length:strlen(string)];
    
    const char *seed_key = [aes128_seed cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *key = [[NSData alloc] initWithBytes:seed_key length:strlen(seed_key)];
    
    if (key.length != 16 && key.length != 24 && key.length != 32)
    {
        return @"";
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return @"";
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          NULL,
                                          stringdata.bytes,
                                          stringdata.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess)
    {
        result = [[NSData alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return [result base64EncodedStringWithOptions:0];
    }
    else
    {
        free(buffer);
        return @"";
    }
}

- (NSString *)ba_aes128Decrypt
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    const char *seed_key = [aes128_seed cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *key = [[NSData alloc] initWithBytes:seed_key length:strlen(seed_key)];
    
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return @"";
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return @"";
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          NULL,
                                          data.bytes,
                                          data.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    } else {
        free(buffer);
        return @"";
    }
}

- (NSString *)ba_md5
{
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (uint32_t)strlen(str), result);
    return [NSString ba_hexString:result withLength:CC_MD5_DIGEST_LENGTH];
}

+ (NSString *)ba_hexString:(uint8_t *)bytes withLength:(NSInteger)len
{
    NSMutableString *output = [NSMutableString stringWithCapacity:len * 2];
    for(int i = 0; i < len; i++) {
        [output appendFormat:@"%02x", bytes[i]];
    }
    return [output copy];
}

- (BOOL)ba_validatePassword {
    //长度8-20位之间
    if (self.length < 8 || self.length > 20) {
        return NO;
    }
    //不允许中文
    for(NSInteger i = 0 ; i < self.length; i++)
    {
        unichar a = [self characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff){
            return NO;
        }
    }
    return YES;
}

@end

