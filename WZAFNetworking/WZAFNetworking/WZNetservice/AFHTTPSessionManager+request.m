//
//  AFHTTPSessionManager+request.m
//  JHNetworking
//
//  Created by juru on 2017/8/7.
//  Copyright © 2017年 juruyi. All rights reserved.
//
// basic 认证用户名
#define authBasicUserName @"user1"

// basic 认证密码
#define authBasicPassword @"user1"

#import "AFHTTPSessionManager+request.h"

@implementation AFHTTPSessionManager (request)
- (void)jhGetPath:(NSString *)path
         delegate:(id)delegate
           params:(NSDictionary *)params
          success:(requestSuccessBlock)success
          failure:(requestFailureBlock)failured{
     [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failured(error);
     }];
}
    


- (void)jhPostPath:(NSString *)path
          delegate:(id)delegate
            params:(NSDictionary *)params
           success:(requestSuccessBlock)success
           failure:(requestFailureBlock)failure{
//    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:authBasicUserName password:authBasicPassword];
#ifdef DBUG
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies = [storage cookies];
    NSHTTPCookie * cookie = [cookies lastObject];
    //    NSLog(@"sessionId-----------------[%@]-------------------------",cookie.value);
#endif
    [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
   
}

@end
