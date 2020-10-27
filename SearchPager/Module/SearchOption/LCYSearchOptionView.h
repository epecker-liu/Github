//
//  LCYSearchOptionView.h
//  GitHub
//
//  Created by bytedance on 2020/10/26.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCYprotocolDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchOptionView : UIView <LCYprotocolDelegate>

@property(nonatomic, weak) id<LCYprotocolDelegate> delegate;

- (void)updateSearchString:(NSString *)searchString;

@end

NS_ASSUME_NONNULL_END
