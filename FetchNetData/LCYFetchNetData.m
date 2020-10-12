//
//  fetchNetData.m
//  GitHub
//
//  Created by bytedance on 2020/10/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYFetchNetData.h"
#import <AFNetworking/AFNetworking.h>
//#import <AFURLSessionManager.h>


@implementation LCYFetchNetData

- (void)getData
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *url = @"https://api.github.com/users/epecker-liu/repos?access_token=96ef2a6ba724ba24aeeee98c02ce25114410b5b5";
    //把请求头进行 UTF-8编码
    NSString *path = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manger GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"success");
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
        NSLog(@"error: %@", error);
    }];
}

@end
