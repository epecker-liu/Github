//
//  LoginAlertController.h
//  GitHub
//
//  Created by bytedance on 2020/10/4.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginAlertView : UIView

/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;
/** 弹窗标题 */
@property (nonatomic,copy)   NSString *title;
/** 弹窗message */
@property (nonatomic,copy)   NSString *message;
/** message label */
@property (nonatomic,strong) UILabel  *messageLabel;
/** 左边按钮title */
@property (nonatomic,copy)   NSString *leftButtonTitle;
/** 右边按钮title */
@property (nonatomic,copy)   NSString *rightButtonTitle;

@property (nonatomic, strong) UITextField *userTextView;

@property (nonatomic, strong) UITextField *passwordTextView;

@property (nonatomic, strong) UIButton *loginButton;
-(void) show;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
