//
//  LCYShowRepOfNetControllerViewController.h
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LCYFetchNetDataService.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LCYNetworkFetchDataCompletion)(NSMutableArray *, NSError *);   //回调代码块

@interface LCYShowRepOfNetViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
