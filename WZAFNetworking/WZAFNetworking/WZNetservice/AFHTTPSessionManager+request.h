//
//  AFHTTPSessionManager+request.h
//  JHNetworking
//  wangzhao
//  Created by juru on 2017/8/7.
//  Copyright © 2017年 juruyi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);
@interface AFHTTPSessionManager (request)

/**
    网络访问的get方法
    @param path 访问的路径
    @param delegate 回调方法的代理
    @param params 网络请求的参数
 
 
 */
- (void)jhGetPath:(NSString *)path
         delegate:(id)delegate
           params:(NSDictionary *)params
          success:(requestSuccessBlock)success
          failure:(requestFailureBlock)failured;
    
/** 
    网络请求的post方法
    @param path 访问的路径
    @param delegate 回调方法的代理
    @param params 网络请求的参数
 
 
 */

- (void)jhPostPath:(NSString *)path
          delegate:(id)delegate
            params:(NSDictionary *)params
           success:(requestSuccessBlock)success
           failure:(requestFailureBlock)failure;



@end
