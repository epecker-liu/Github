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
#import "LCYRepModel.h"
#import "LCYMyWorkData.h"

//#import <AFURLSessionManager.h>


@implementation LCYFetchNetData

- (void)getData
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *url = @"https://api.github.com/users/epecker-liu/repos?access_token=451b5787299c450663fcab3c15eb0b30deb38fb7";
    //把请求头进行 UTF-8编码
    NSString *path = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSError *error;
    [manger GET:path parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray<NSDictionary *> * _Nullable responseObject){
        [responseObject enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LCYRepModel *object = [MTLJSONAdapter modelOfClass:[LCYRepModel class] fromJSONDictionary:obj error:nil];
                LCYMyWorkData *aRep = [[LCYMyWorkData alloc] initWithWorkName:object.fullName WorkImage:object.repOwners.imageUrl];
                //[_repositoriesList addObject:aRep];
            }];
            
        } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"fail");
        }];
//    [manger GET:path parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//        NSLog(@"success");
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"fail");
//        NSLog(@"error: %@", error);
//    }];
}

@end
