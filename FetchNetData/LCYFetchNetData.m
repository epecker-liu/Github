//
//  fetchNetData.m
//  GitHub
//
//  Created by bytedance on 2020/10/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYFetchNetData.h"
#import <AFNetworking/AFNetworking.h>
#import <Mantle.h>
#import "LCYUserModel.h"
#import "LCYMyWorkData.h"
#import "LCYItemModel.h"

//#import <AFURLSessionManager.h>


@implementation LCYFetchNetData

- (void)getData:(NSString *)url completion:(LCYNetworkFetchDataCompletion)completion
{
    NSMutableArray *_repositoriesList = [[NSMutableArray alloc] init];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *path = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSError *error;
    [manger GET:path parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray<NSDictionary *> * _Nullable responseObject){
        [responseObject enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSError *merror = nil;
            LCYItemModel *fullName = [MTLJSONAdapter modelOfClass:[LCYItemModel class] fromJSONDictionary:obj error:nil];
            stop = NO;
            if(merror){
                NSLog(@"error-----%@", merror);
            }else{
                [_repositoriesList addObject:fullName];
                NSLog(@"full name ------- %@", fullName);
            }
            }];
            if(completion){
                NSLog(@"success");
                completion(_repositoriesList, nil);
            }
        } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
            if (completion) {
                completion(nil, error);
            }
        }];
}

@end
