//
//  LCYSearchOptionView.m
//  GitHub
//
//  Created by bytedance on 2020/10/26.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchOptionView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LCYSearchOptionsCell.h"
#import <Masonry/Masonry.h>
#import "LCYSearchRepositoriesViewController.h"
#import "LCYSearchUserViewController.h"
#import <WHToast.h>
#import "LCYSearchDelegate.h"

@interface LCYSearchOptionView()

@property (nonatomic, strong) UITableView *searchOptionsTableView;
@property (nonatomic, strong) NSString *searchString;

@end

@implementation LCYSearchOptionView

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (instancetype) init
{
    if (self = [super init]) {
//         接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//         UI搭建
//        self = [[UIView alloc] init];
        [self initHistoryRecordUI];
    }
    return self;
}

- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(self.searchString, length) subscribeNext:^ (id x){
        @strongify(self);
        [self.searchOptionsTableView reloadData];
    }];
}

- (void)initHistoryRecordUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.searchOptionsTableView = [[UITableView alloc] init];
    self.searchOptionsTableView.dataSource = self;
    self.searchOptionsTableView.delegate = self;
    [self.searchOptionsTableView registerClass: [LCYSearchOptionsCell class] forCellReuseIdentifier:NSStringFromClass([LCYSearchOptionsCell class])];
    [self.searchOptionsTableView setSeparatorColor:[UIColor blackColor]];
    [self addSubview:self.searchOptionsTableView];
    [self.searchOptionsTableView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.equalTo(self.mas_top);
        make.height.equalTo(self.mas_height);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    LCYSearchOptionsCell *searchOptionsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYSearchOptionsCell class]) forIndexPath:indexPath];
    searchOptionsCell.backgroundColor = [UIColor whiteColor];
    searchOptionsCell.selectionStyle = UITableViewScrollPositionNone;
    if (5 > indexPath.row) {
        [searchOptionsCell updateWithString:self.searchString indexPath:indexPath.row];
    }
    return searchOptionsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            LCYSearchRepositoriesViewController *searchRepositoriesViewController = [[LCYSearchRepositoriesViewController alloc] init];
            [searchRepositoriesViewController setSearchText:self.searchString];
            [self.delegate routeToViewController:searchRepositoriesViewController];
            break;
        }
        case 1:
            [WHToast showErrorWithMessage:@"查找议题" duration:0.5 finishHandler:^{
            }];
            break;
        case 2:
            [WHToast showImage:[UIImage imageNamed:@"github_icon.png"] message:@"查找拉去请求" duration:0.5 finishHandler:^{
            }];
            break;
        case 3: {
            LCYSearchUserViewController *searchUserViewController = [[LCYSearchUserViewController alloc] init];
            [searchUserViewController setSearchText:self.searchString];
            [self.delegate routeToViewController:searchUserViewController];
            break;
        }
        case 4:
            [WHToast showSuccessWithMessage:@"查找组织" duration:0.5 finishHandler:^{
            }];
            break;
        default:
            break;
    }
}

- (void)updateSearchString:(NSString *)searchString
{
    self.searchString = searchString;
    [self.searchOptionsTableView reloadData];
}

@end
