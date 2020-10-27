//
//  LCYprotocolDelegate.h
//  GitHub
//
//  Created by bytedance on 2020/10/27.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LCYprotocolDelegate <NSObject>

@required
- (void) routeToViewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
