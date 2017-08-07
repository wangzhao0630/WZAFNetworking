//
//  ViewController.m
//  WZAFNetworking
//
//  Created by juru on 2017/8/7.
//  Copyright © 2017年 wangzhao. All rights reserved.
//
#import "NetServiceManager.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *dataDic;

@end

@implementation ViewController
- (IBAction)postData:(id)sender {
    [[NetServiceManager shareManager] recommendedProductInfo:@"2" delegate:self success:^(id responseObject) {
        self.dataDic.text = [self jsonToString:responseObject];
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
*  json转字符串
*/
- (NSString *)jsonToString:(NSDictionary *)dic
{
    if(!dic){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
