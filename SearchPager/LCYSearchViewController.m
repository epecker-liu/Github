//
//  SearchViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchViewController.h"
#import "LCYFetchNetDataService.h"
#import <Masonry/Masonry.h>
#import <Mantle/Mantle.h>
#import "LCYSearchUserViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MJRefresh/MJRefresh.h>
#import "LCYSearchUserCell.h"
#import "LCYHistoryRecordModel.h"
#import "LCYHistoryRecordViewModel.h"
#import <NSUserDefaults+RACSupport.h>
#import "LCYHistoryRecordCell.h"
#import "LCYHistoryRecordModel.h"
#import "LCYHistoryRecordViewModel.h"
#import "LCYSearchOptionsCell.h"
#import "LCYSearchUserViewController.h"
#import <WHToast/WHToast.h>
#import "LCYSearchRepositoriesViewController.h"
#include "LCYConstValue.h"
#import "LCYSearchOptionView.h"
#import "LCYHistoryRecordView.h"

@interface LCYSearchViewController ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *temp;
@property (nonatomic, strong) LCYSearchOptionView *searchOptionsView;
@property (nonatomic, strong) LCYHistoryRecordView *historyRecordView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LCYSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSearchPageUI];
    [self bindViewModel];
}

- (void)bindViewModel
{
    @weakify(self);
    [[[self.searchTextField.rac_textSignal filter:^ bool(NSString *value){
        return YES;
    }]map:^ id(NSString *value){
        @strongify(self);
        if (value.length == 0) {
            [self.historyRecordView updateSearchString:self.searchTextField.text];
            self.historyRecordView.alpha = 0;
            self.historyRecordView.transform = CGAffineTransformScale(self.historyRecordView.transform, 0.5, 0.5);
            [UIView animateWithDuration:0.5 animations:^{
                self.historyRecordView.alpha = 1;
                self.historyRecordView.transform = CGAffineTransformIdentity;
            }];
            self.historyRecordView.hidden = NO;
            self.searchOptionsView.hidden = YES;
            return [UIColor yellowColor];
        } else {
            [self.searchOptionsView updateSearchString:self.searchTextField.text];
            if (self.searchOptionsView.hidden == YES) {
                self.historyRecordView.alpha = 1;
                self.historyRecordView.transform = CGAffineTransformScale(self.historyRecordView.transform, 1, 1);
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.historyRecordView.alpha = 0;
                    self.historyRecordView.transform = CGAffineTransformScale(self.historyRecordView.transform, 0.5, 0.5);
                } completion:nil];
                self.searchOptionsView.alpha = 0;
                self.searchOptionsView.transform = CGAffineTransformScale(self.historyRecordView.transform, 0.5, 0.5);
                [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.searchOptionsView.alpha = 1;
                    self.searchOptionsView.transform = CGAffineTransformIdentity;
                } completion:nil];
            }
            self.searchOptionsView.hidden = NO;
            return [UIColor greenColor];
        }
    }] subscribeNext:^(UIColor *value){
        self.searchTextField.backgroundColor = value;
    }];
    
    [RACObserve(self.historyRecordView, searchString) subscribeNext:^ (id x){
        @strongify(self);
        self.searchTextField.text = self.historyRecordView.searchString;
    }];
}

#pragma mark - UI

- (void)initSearchPageUI
{
    self.searchTextField = [[UITextField alloc] init];
    [self.searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.placeholder = @"search";
    self.searchTextField.font = [UIFont systemFontOfSize:20];
    [self.searchTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.searchTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^ (MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left).mas_offset(10);
        make.top.equalTo(self.view.mas_top).offset(110);
        make.width.mas_equalTo(self.view.mas_width).mas_offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"近期搜索";
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.searchTextField.mas_bottom).mas_offset(15);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchOptionsView = [[LCYSearchOptionView alloc] init];
    [self.view addSubview: self.searchOptionsView];
    [self.searchOptionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(180);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(-50);
    }];
    self.searchOptionsView.delegate = self;
    
    self.historyRecordView = [[LCYHistoryRecordView alloc] init];
    [self.view addSubview: self.historyRecordView];
    [self.historyRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.searchTextField.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(-50);
    }];
}

- (void)updateFieldText:(NSString *)str
{
    self.searchTextField.text = str;
}

- (void) routeToViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

@end
