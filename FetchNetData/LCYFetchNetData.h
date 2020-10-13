//
//  fetchNetData.h
//  GitHub
//
//  Created by bytedance on 2020/10/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCYMyWorkData;

NS_ASSUME_NONNULL_BEGIN


typedef void(^LCYNetworkFetchDataCompletion)(NSMutableArray *, NSError *);   //回调代码块

@interface LCYFetchNetData : NSObject

- (void)getData:(NSString *)url completion:(LCYNetworkFetchDataCompletion)completion;

@end


NS_ASSUME_NONNULL_END
