//
//  LoginAlertController.m
//  GitHub
//
//  Created by bytedance on 2020/10/4.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYLoginAlertView.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import <Masonry/Masonry.h>
#import "LCYTabBarController.h"


@interface LCYLoginAlertView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *leftButtonTitle;
@property (nonatomic, copy) NSString *rightButtonTitle;
@property (nonatomic, strong) UITextField *userTextView;
@property (nonatomic, strong) UITextField *passwordTextView;
@property (nonatomic, strong) UITextView  *titleTextView;
@property (nonatomic, strong) UIImageView *githubIconImage;

@end


@implementation LCYLoginAlertView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (instancetype)init
{
    if (self = [super init]){
        // 接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        // UI搭建
        [self initLoginAlertUI];
    }
    return self;
}

#pragma mark - UI

- (void) initLoginAlertUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //set github icon image
    self.githubIconImage = [[UIImageView alloc] init];
    UIImage *icon = [UIImage imageNamed:@"github_icon.png"];
    self.githubIconImage.image = icon;
    
    //set content view
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //set title text view
    self.titleTextView = [[UITextView alloc] init];
    self.titleTextView.editable = NO;
    self.titleTextView.delegate = self;
    self.titleTextView.scrollEnabled = YES;  //可以换行
    self.titleTextView.text = @"Sign in to GitHub to continue to GitHub iOS";
    self.titleTextView.font = [UIFont systemFontOfSize:20];
    
    //set password text view
    self.passwordTextView = [[UITextField alloc]initWithFrame:CGRectMake(20, 42, self.contentView.bounds.size.width, 14)];
    self.passwordTextView.placeholder = @"password";
    [self.passwordTextView setBorderStyle:UITextBorderStyleRoundedRect];
    self.passwordTextView.backgroundColor = [UIColor whiteColor];
    self.passwordTextView.font = [UIFont systemFontOfSize:12];
    
    //set user text view
    self.userTextView = [[UITextField alloc] initWithFrame:CGRectMake(20, 42, self.contentView.bounds.size.width, 30)];
    self.userTextView.placeholder = @"username";
    [self.userTextView setBorderStyle: UITextBorderStyleRoundedRect];
    self.userTextView.backgroundColor = [UIColor whiteColor];
    self.userTextView.font = [UIFont systemFontOfSize: 12];
    
    //set login button
    self.loginButton = [[UIButton alloc] init];
    self.loginButton.backgroundColor = [UIColor greenColor];
    [self.loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 6;
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(300,400));
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-40);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.contentView addSubview:self.githubIconImage];
    [self.githubIconImage mas_makeConstraints:^ (MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(60,60));
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(90);
        make.centerX.mas_equalTo(self.contentView);
    }];

    [self.contentView addSubview:self.titleTextView];
    [self.titleTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.githubIconImage.mas_bottom).offset(5);
    }];
    
    [self.contentView addSubview:self.userTextView];
    [self.userTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
    
    [self.contentView addSubview:self.passwordTextView];
    [self.passwordTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(70);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
    
    [self.contentView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^ (MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.passwordTextView.mas_centerY).mas_offset(50);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
}

#pragma mark -button event

- (void) login
{
    LCYTabBarController *tabbar = [[LCYTabBarController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:tabbar];
    [self.window setRootViewController:navigation];
}


@end
