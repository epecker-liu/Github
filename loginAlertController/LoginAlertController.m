//
//  LoginAlertController.m
//  GitHub
//
//  Created by bytedance on 2020/10/4.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LoginAlertController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import <Masonry/Masonry.h>
#import "TabBarController.h"


@interface LoginAlertController ()<UITextViewDelegate>
@property (nonatomic, strong) UIImageView *githubIconImage;
@property (nonatomic, strong) UITextView  *titleTextView;
@end


@implementation LoginAlertController

- (instancetype)init{
    if (self = [super init]) {
        // 接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        // UI搭建
        [self initLoginAlertUI];
    }
    return self;
}

- (void) initLoginAlertUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self addSubview:self.contentView];
    [self setConstraintContentView];
    
    [self.contentView addSubview:self.githubIconImage];
    [self setConstraintGithubIconImage];
    // 标题
    [self.contentView addSubview:self.titleTextView];
    [self setConstraintTitleTextView];
    
    [self.contentView addSubview:self.userTextView];
    [self setConstraintUserTextView];
    
    [self.contentView addSubview:self.passwordTextView];
    [self setConstraintPasswordTextView];
    
    [self.contentView addSubview:self.loginButton];
    [self setConstraintLoginButton];
}

#pragma mark -- setConstraint

- (void) setConstraintGithubIconImage{
    [self.githubIconImage mas_makeConstraints:^ (MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(60,60));
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(90);
        make.centerX.mas_equalTo(self.contentView);
    }];
}

- (void) setConstraintContentView{
    [self.contentView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(300,400));
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-40);
        make.centerX.mas_equalTo(self);
    }];
}

- (void) setConstraintTitleTextView{
    [self.titleTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.githubIconImage.mas_bottom).offset(5);
    }];
}

- (void) setConstraintUserTextView{
    [self.userTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
}

- (void) setConstraintPasswordTextView{
    [self.passwordTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(70);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
}

- (void) setConstraintLoginButton{
    [self.loginButton mas_makeConstraints:^ (MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.passwordTextView.mas_centerY).mas_offset(50);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
}

#pragma mark --init view

- (UIImageView *)githubIconImage
{
    if (!_githubIconImage) {
        _githubIconImage = [[UIImageView alloc] init];
        UIImage *icon = [UIImage imageNamed:@"github_icon.png"];
        _githubIconImage.image = icon;
    }
    return _githubIconImage;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UITextView *)titleTextView{
    if(!_titleTextView){
        _titleTextView = [[UITextView alloc] init];
        _titleTextView.editable = NO;
        _titleTextView.delegate = self;
        _titleTextView.scrollEnabled = YES;  //可以换行
        _titleTextView.text = @"Sign in to GitHub to continue to GitHub iOS";
        _titleTextView.font = [UIFont systemFontOfSize:20];
    }
    return _titleTextView;
}

- (UITextField *)passwordTextView{
    if(!_passwordTextView){
        _passwordTextView = [[UITextField alloc]initWithFrame:CGRectMake(20, 42, self.contentView.bounds.size.width, 14)];
        _passwordTextView.placeholder = @"password";
        [_passwordTextView setBorderStyle:UITextBorderStyleRoundedRect];
        _passwordTextView.backgroundColor = [UIColor whiteColor];
        _passwordTextView.font = [UIFont systemFontOfSize:12];
        //[self.textView becomeFirstResponder];
        //self.textView.delegate = self;
    }
    return _passwordTextView;
}

- (UITextField *)userTextView{
    if(!_userTextView){
        _userTextView = [[UITextField alloc] initWithFrame:CGRectMake(20, 42, self.contentView.bounds.size.width, 30)];
        _userTextView.placeholder = @"username";
        [_userTextView setBorderStyle: UITextBorderStyleRoundedRect];
        _userTextView.backgroundColor = [UIColor whiteColor];
        _userTextView.font = [UIFont systemFontOfSize: 12];
    }
    return _userTextView;
}

- (UIButton *)loginButton{
    if(!_loginButton){
        _loginButton = [[UIButton alloc] init];
         _loginButton.backgroundColor = [UIColor greenColor];
        [_loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 6;
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

#pragma mark -button event

- (void) login{
    TabBarController *tabbar = [[TabBarController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:tabbar];
    [self.window setRootViewController:navigation];
    //期望弹出新的视图后原先的登录视图消失。
}

#pragma mark -- show

- (void)show {
    // 出场动画
    self.alpha = 0;
    self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 1.3, 1.3);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformIdentity;
    }];
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
}

@end
