//
//  NSDictionary+BASign.h
//  BeautyAccount
//
//  Created by Quincy on 2017/8/10.
//  Copyright © 2017年 Beauty,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Sign)

/**
 字典->排序的jsonStr
 
 @return jsonStr
 */
- (NSString *)ba_orderJsonString;

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
- (NSDictionary *)ba_addSignWithParams:(NSDictionary *)paramDic;

/**
 将字典转queryString
 
 param = "A=XXX&B=XXX&F=XXX"
 
 */
- (NSString *)ba_dicToQueryString;

@end

@interface NSArray (Sign)

- (NSString *)ba_orderJsonString;

@end


