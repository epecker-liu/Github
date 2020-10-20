//
//  fetchNetData.m
//  GitHub
//
//  Created by bytedance on 2020/10/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYFetchNetDataService.h"
#import <AFNetworking/AFNetworking.h>
#import <Mantle.h>
#import "LCYUserModel.h"
#import "LCYMyWorkData.h"
#import "LCYItemModel.h"

//#import <AFURLSessionManager.h>


@implementation LCYFetchNetDataService

- (void)fetchDateFromURL:(NSString *)url completion:(LCYNetworkFetchDataCompletion)completion
{
    NSMutableArray *repositoriesList = [[NSMutableArray alloc] init];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *path = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSError *error;
    [manger GET:path parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject){
            if(completion){
                NSLog(@"success");
                completion(responseObject, nil);
            }
        } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
            if (completion) {
                completion(nil, error);
            }
        }];
}

@end