//
//  NSDictionary+BASign.m
//  BeautyAccount
//
//  Created by Quincy on 2017/8/10.
//  Copyright © 2017年 Beauty,Inc. All rights reserved.
//

#import "NSDictionary+BASign.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSString+BAEncrypt.h"


@implementation NSDictionary (Sign)

- (NSMutableDictionary *)ba_addSign {
    // 1. 排序&拼接
    NSString *encryptString = [self ba_dicToQueryString];
    
    //特殊处理,服务器端签名取的是原始字符串排序签名,'\'到服务器的原始数据实际上是'\\',需要对这个进行特殊处理
    encryptString = [encryptString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    
    // 2. URLEncode
    NSString *keyStringEncode = [encryptString ba_urlEncode];
    
    // 3. SHA256加密 (SHA256自带Base64)
    NSString *keySHA256Encode = [keyStringEncode ba_sha256];
    
    // 4. URLEncode
    NSString *keyStringEncode2 = [keySHA256Encode ba_urlEncode];
    
    NSMutableDictionary *mDic = self.mutableCopy;
    [mDic setObject:keyStringEncode2 forKey:@"sign"];
    
    return mDic;
}

/**
 将转换成如下格式,如果paramDic = nil，只会根据自身参数进行加密
 
 @{@"param" : @{除了通用字段外的特定字段},
 @"sign" : @"",
 @"通用字段1" : @"",
 @"通用字段2" : @"",
 ...
 ...
 }
 */
- (NSDictionary *)ba_addSignWithParams:(NSDictionary *)paramDic {
    NSMutableDictionary *dic = self.mutableCopy;
    [dic setValue:paramDic forKey:@"param"];
    return  [dic ba_addSign];
}

/**
 字典->排序的jsonStr
 
 @return jsonStr
 */
- (NSString *)ba_orderJsonString {
    
    NSArray *keys = [self.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *jsonStr = [[NSMutableString alloc] initWithString:@"{"];
    for (NSString *key in keys) {
        id value = [self objectForKey:key];
        
        if ([value isKindOfClass:[NSString class]]) {
            [jsonStr appendFormat:@"\"%@\":\"%@\",",key,value];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            [jsonStr appendFormat:@"\"%@\":%@,",key,value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [jsonStr appendFormat:@"\"%@\":%@,", key, [value ba_orderJsonString]];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            [jsonStr appendFormat:@"\"%@\":%@,", key, [value ba_orderJsonString]];
        }
    }
    if ([jsonStr hasSuffix:@","]) {
        [jsonStr deleteCharactersInRange:NSMakeRange(jsonStr.length-1, 1)];
    }
    [jsonStr appendFormat:@"}"];
    
    return jsonStr;
}

/*
 将字典用ASICC码排序并且串起来
 
 param = "A=XXX&B=XXX&F=XXX"
 
 */
- (NSString *)ba_dicToQueryString {
    if (self.allKeys.count == 0) return @"";
    NSArray *keys = [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableDictionary *dic = self.mutableCopy;
    NSString *str = @"";
    for (NSString *key in keys) {
        id value = dic[key];
        //字典数组转json字符串
        if ([value isKindOfClass:[NSDictionary class]]) {
            dic[key] = [value ba_orderJsonString];
        }
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,dic[key]]];
    }
    return [str substringToIndex:str.length - 1];
}

@end


@implementation NSArray (Sign)

- (NSString *)ba_orderJsonString {
    NSMutableString *jsonStr = [[NSMutableString alloc] initWithString:@"["];
    for (id object in self) {
        if ([object isKindOfClass:[NSArray class]]) {
            [jsonStr appendFormat:@"%@,",[object ba_orderJsonString]];
        }else if ([object isKindOfClass:[NSDictionary class]]) {
            [jsonStr appendFormat:@"%@,",[object ba_orderJsonString]];
        }else if ([object isKindOfClass:[NSNumber class]]) {
            [jsonStr appendFormat:@"%@,",object];
        }else if ([object isKindOfClass:[NSString class]]) {
            [jsonStr appendFormat:@"\"%@\",", object];
        }
    }
    if ([jsonStr hasSuffix:@","]) {
        [jsonStr deleteCharactersInRange:NSMakeRange(jsonStr.length-1, 1)];
    }
    [jsonStr appendFormat:@"]"];
    return jsonStr;
}

@end




