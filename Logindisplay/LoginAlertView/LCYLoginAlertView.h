//
//  LoginAlertController.h
//  GitHub
//
//  Created by bytedance on 2020/10/4.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYLoginAlertView : UIView

@property (nonatomic, strong) UIView *contentView;

- (void) show;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
