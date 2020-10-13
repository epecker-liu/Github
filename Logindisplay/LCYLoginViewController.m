//
//  LoginViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/3.
//  Copyright © 2020 bytedance. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "LCYLoginViewController.h"
#import "LCYLoginAlertView.h"
#import "LCYTabBarController.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

@interface LCYLoginViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIImageView *githubIconImage;
@property (nonatomic, strong) UITextView *explainTextView;

@end

@implementation LCYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLoginUI];
}

#pragma mark - initUI

- (void)initLoginUI{
    [self initView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view addSubview:self.githubIconImage];
    [self.githubIconImage mas_makeConstraints:^ (MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(120,120));
        make.bottom.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view);
    }];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(_githubIconImage.mas_bottom).offset(40);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
    }];
    [self.view addSubview:self.explainTextView];
    [self.explainTextView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-25);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(self.view.mas_width);
    }];
}

#pragma mark -initView

- (void)initView
{
    //set github image
    self.githubIconImage = [[UIImageView alloc] init];
    UIImage *icon = [UIImage imageNamed:@"github_icon.png"];
    self.githubIconImage.image = icon;
    
    //set login button
    self.loginButton = [[UIButton alloc] init];
    self.loginButton.backgroundColor = [UIColor blackColor];
    [self.loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 6;
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    //set explain text view
    self.explainTextView = [[UITextView alloc] init];
    self.explainTextView.editable = NO;
    self.explainTextView.delegate = self;
    self.explainTextView.scrollEnabled = YES;  //可以换行
    NSString *explainString = @"By signing in you accept our Terms of use and Privacy policy.";
    NSMutableAttributedString *explainMAString = [[NSMutableAttributedString alloc] initWithString:explainString];
    [explainMAString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[explainString rangeOfString:explainString]]; //字体全部设置为gray
    [explainMAString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[explainString rangeOfString:@"Terms of use"]]; //"Terms of use"设置为blue
    [explainMAString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[explainString rangeOfString:@"Privacy policy"]];//"Privacy policy"设置为blue
    NSString *firstKey = [[NSString stringWithFormat:@"Terms of use"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *secondKey = [[NSString stringWithFormat:@"Privacy policy"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [explainMAString addAttribute:NSLinkAttributeName value:firstKey range:[explainString rangeOfString:@"Terms of use"]];
    [explainMAString addAttribute:NSLinkAttributeName value:secondKey range:[explainString rangeOfString:@"Privacy policy"]];
    self.explainTextView.attributedText = explainMAString;
    self.explainTextView.font = [UIFont fontWithName:@"Arial" size:14];
    self.explainTextView.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - button event

- (void)login
{
    LCYLoginAlertView *vc = [[LCYLoginAlertView alloc] init];
    vc.alpha = 0;
    vc.contentView.transform = CGAffineTransformScale(vc.contentView.transform, 2, 2);
    [UIView animateWithDuration:0.5 animations:^{
        vc.alpha = 1;
        vc.contentView.transform = CGAffineTransformIdentity;
    }];
    [self.view addSubview:vc];
}

@end
