//
//  NetServiceManager.h
//  JHNetworking
//  wangzhao
//  Created by juru on 2017/8/7.
//  Copyright © 2017年 juruyi. All rights reserved.
//
//@new 精品推荐
#define kRecommend @"recommend"
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetServiceManager : NSObject
+ (NetServiceManager *)shareManager;

- (void)recommendedProductInfo:(NSString *)platform
                      delegate:(id)delegate
                       success:(void (^)(id responseObject))success
                       failure:(void(^)(NSError *error))failure;
@end
