//
//  NetServiceManager.m
//  JHNetworking
//
//  Created by juru on 2017/8/7.
//  Copyright © 2017年 juruyi. All rights reserved.
//
#import <SVProgressHUD.h>
#import "AFHTTPSessionManager+request.m"
#import "NetServiceManager.h"
#define URL_BASE @"http://trade.juruyi168.com/mobile"

// 成功
#define kNetworkSuccessCode             1

// 参数异常
#define kNetworkParametersInvalied      2

// 需要登录
#define kNetworkNeedLogin               3

// 系统内部异常
#define kNetworkInnerException          9
// 状态码
#define kNetWorkCode         @"code"
// 数据实体
#define kNetWorkDataBody     @"data"
// 列表实体
#define kNetWorkList         @"list"
// 错误信息
#define kNetWorErrorMsg      @"message"
// 错误域
#define kErrorCMMDomain      @"kNetWorkErrorDomain"


@interface NetServiceManager ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
//统一处理数据
-(void)catchNetResWithResInfo:(id )info
                      success:(void(^)(id resBody)) success
                        error:(void(^)(NSError* error)) failure
                     delegate:(UIViewController *) delegate
                         path:(NSString *)path;

@end

@implementation NetServiceManager

+(NetServiceManager *)shareManager{
    static dispatch_once_t onceToken;
    static NetServiceManager *sShareInstance;
    dispatch_once(&onceToken, ^{
        sShareInstance = [[NetServiceManager alloc] init];
    });
    return sShareInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE] sessionConfiguration:nil];
    }
    return self;
}
/**
 统一的数据处理
 @param info 网络返回的data
 */
-(void)catchNetResWithResInfo:(id )info
                      success:(void(^)(id resBody)) success
                        error:(void(^)(NSError* error)) failure
                     delegate:(UIViewController *) delegate
                         path:(NSString *)path
{
    
    if (delegate == nil) {
        return;
    }
    if ([delegate isKindOfClass:[UIViewController class]]) {
       // [CMMUtility hideWaitingAlertView];
    }
    //网络请求成功
    NSDictionary *dic = info;
    
    NSLog(@"网络响应数据【%@】",dic);
    
    NSNumber *resCode = [dic objectForKey:kNetWorkCode];
    
    switch (resCode.integerValue) {
        case 1:
            //成功
        {
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
            NSDictionary *data = [dic objectForKey:kNetWorkDataBody];
            if (success) {
                success(data);
            }
        }
            break;
        case 2:
            //失败，参数异常
            [SVProgressHUD showErrorWithStatus:@"提交的参数异常,请检查后重新提交!"];
            
            break;
        case 3:
            //失败，用户未登录
        {
            //[CMMUtility showTMPLogin];
            //登陆异常
            NSError *error = [NSError errorWithDomain:kErrorCMMDomain code:resCode.integerValue userInfo:nil];
            if (failure) {
                failure(error);
            }
        }
            break;
        case 9:
            //失败，系统异常
        {
            NSDictionary *data = [dic objectForKey:kNetWorkDataBody];
            if (data && [data isKindOfClass:[NSDictionary class]]) {
                NSString *msg = [data objectForKey:kNetWorErrorMsg];
                // NSLog(@"errorMSG:%@",msg);
                if (msg) {
                    NSError *error = [NSError errorWithDomain:kErrorCMMDomain code:kNetworkInnerException userInfo:[NSDictionary dictionaryWithObject:msg forKey:kNetWorErrorMsg]];
                    failure(error);
                }else {
                   // [CMMUtility showNote:@"抱歉,系统异常,请稍候重试!"];
                }
            }
            failure([NSError errorWithDomain:kErrorCMMDomain code:resCode.intValue userInfo:nil]);
        }
            
            break;
        default:
        {
            NSString *errorMSG = [dic objectForKey:kNetWorErrorMsg];
            if (errorMSG && [errorMSG isKindOfClass:[NSString class]]) {
                NSMutableDictionary *errorData = [NSMutableDictionary dictionaryWithCapacity:1];
                [errorData setObject:errorMSG forKey:kNetWorErrorMsg];
                // NSLog(@"msg:%@",errorMSG);
                failure([NSError errorWithDomain:kErrorCMMDomain code:resCode.intValue userInfo:errorData]);
            }else {
                failure([NSError errorWithDomain:kErrorCMMDomain code:resCode.intValue userInfo:nil]);
            }
        }
            break;
    }
}

-(NSMutableDictionary *)buildParametersDic {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
}
// 精品推荐
- (void)recommendedProductInfo:(NSString *)platform
                      delegate:(id)delegate
                       success:(void (^)(id responseObject))success
                       failure:(void(^)(NSError *error))failure {
    assert(platform);
    
    //[CMMUtility showWaitingAlertView];
    
    NSMutableDictionary *param = [self buildParametersDic];
    //产品通道Id，钱宝宝的productChannelId
    [param setObject:@"2" forKey:@"productChannelId"];
    [_manager jhPostPath:kRecommend delegate:delegate params:param success:^(id responObject) {
        
        [self catchNetResWithResInfo:responObject success:success error:failure delegate:delegate path:kRecommend];
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
