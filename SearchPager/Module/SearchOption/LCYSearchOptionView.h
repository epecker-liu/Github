//
//  LCYSearchOptionView.h
//  GitHub
//
//  Created by bytedance on 2020/10/26.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCYSearchDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchOptionView : UIView <LCYSearchDelegate>

- (void)updateSearchString:(NSString *)searchString;

@property(nonatomic, weak) id<LCYSearchDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
