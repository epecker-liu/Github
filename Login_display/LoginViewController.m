//
//  LoginViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/3.
//  Copyright © 2020 bytedance. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "LoginViewController.h"
#import "LoginAlertController.h"
#import "TabBarController.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

@interface LoginViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIImageView *githubIconImage;
@property (nonatomic, strong) UITextView *explainTextView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLoginUI];
}

#pragma mark -initUI

- (void) initLoginUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view addSubview:self.githubIconImage];
    [self setConstraintGithubIconImage];
    [self.view addSubview:self.loginButton];
    [self setConstraintLoginButton];
    [self.view addSubview:self.explainTextView];
    [self setConstraintExplainTextView];
}

#pragma mark - addConstraint

- (void) setConstraintGithubIconImage{
    [self.githubIconImage mas_makeConstraints:^ (MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(120,120));
        make.bottom.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void) setConstraintLoginButton{
    [self.loginButton mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(_githubIconImage.mas_bottom).offset(40);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
    }];
}

- (void) setConstraintExplainTextView{
    [self.explainTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-25);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(self.view.mas_width);
    }];

}

#pragma mark -initView

- (UIImageView *)githubIconImage
{
    if (!_githubIconImage) {
        _githubIconImage = [[UIImageView alloc] init];
        UIImage *icon = [UIImage imageNamed:@"github_icon.png"];
        _githubIconImage.image = icon;
    }
    return _githubIconImage;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.backgroundColor = [UIColor blackColor];
        [_loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 6;
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UITextView *)explainTextView{
    if(!_explainTextView){
        _explainTextView = [[UITextView alloc] init];
        _explainTextView.editable = NO;
        _explainTextView.delegate = self;
        _explainTextView.scrollEnabled = YES;  //可以换行
        NSString *explainString = @"By signing in you accept our Terms of use and Privacy policy.";
        NSMutableAttributedString *explainMAString = [[NSMutableAttributedString alloc] initWithString:explainString];
        [explainMAString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[explainString rangeOfString:explainString]]; //字体全部设置为gray
        [explainMAString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[explainString rangeOfString:@"Terms of use"]]; //"Terms of use"设置为blue
        [explainMAString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[explainString rangeOfString:@"Privacy policy"]];//"Privacy policy"设置为blue
        NSString *firstKey = [[NSString stringWithFormat:@"Terms of use"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSString *secondKey = [[NSString stringWithFormat:@"Privacy policy"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [explainMAString addAttribute:NSLinkAttributeName value:firstKey range:[explainString rangeOfString:@"Terms of use"]];
        [explainMAString addAttribute:NSLinkAttributeName value:secondKey range:[explainString rangeOfString:@"Privacy policy"]];
        _explainTextView.attributedText = explainMAString;
        _explainTextView.font = [UIFont fontWithName:@"Arial" size:14];
        _explainTextView.textAlignment = NSTextAlignmentCenter;
    }
    return _explainTextView;
}

#pragma mark -button event

- (void) login{
    
    LoginAlertController *vc = [[LoginAlertController alloc] init];
    [vc show];
}

@end
