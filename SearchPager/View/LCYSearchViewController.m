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

@interface LCYSearchViewController ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) LCYSearchUserViewModel *searchViewModel;
@property (nonatomic, strong) NSMutableArray *temp;
@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) LCYHistoryRecordViewModel *historyRecordViewModel;
@property (nonatomic, strong) LCYHistoryRecordModel *historyRecordModel;
@property (nonatomic, strong) UITableView *historyRecordTableView;
@property (nonatomic, strong) UITableView *searchOptionsTableView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LCYSearchViewController

- (void)viewDidLoad
{
    self.searchViewModel = [[LCYSearchUserViewModel alloc] init];
    self.historyRecordViewModel = [[LCYHistoryRecordViewModel alloc] init];
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
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            self.historyRecordViewModel.historyRecordModel.historyRecordArray = [defaults arrayForKey:@"historyRecord"];
            [self.historyRecordTableView reloadData];
            self.historyRecordTableView.alpha = 0;
            self.historyRecordTableView.transform = CGAffineTransformScale(self.historyRecordTableView.transform, 0.5, 0.5);
            [UIView animateWithDuration:0.5 animations:^{
                self.historyRecordTableView.alpha = 1;
                self.historyRecordTableView.transform = CGAffineTransformIdentity;
            }];
            self.historyRecordTableView.hidden = NO;
            self.searchOptionsTableView.hidden = YES;
            return [UIColor yellowColor];
        } else if (value.length == 1){
            self.historyRecordTableView.alpha = 1;
            self.historyRecordTableView.transform = CGAffineTransformScale(self.historyRecordTableView.transform, 1, 1);
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.historyRecordTableView.alpha = 0;
                self.historyRecordTableView.transform = CGAffineTransformScale(self.historyRecordTableView.transform, 0.5, 0.5);
            } completion:false];
            self.searchOptionsTableView.alpha = 0;
            self.searchOptionsTableView.transform = CGAffineTransformScale(self.historyRecordTableView.transform, 0.5, 0.5);
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.searchOptionsTableView.alpha = 1;
                self.searchOptionsTableView.transform = CGAffineTransformIdentity;
            } completion:false];
            self.searchOptionsTableView.hidden = NO;
            [self.searchOptionsTableView reloadData];
            return [UIColor greenColor];
        } else {
            self.searchOptionsTableView.hidden = NO;
            self.historyRecordTableView.hidden = YES;
            [self.searchOptionsTableView reloadData];
            return [UIColor blueColor];
        }
    }] subscribeNext:^(UIColor *value){
        self.searchTextField.backgroundColor = value;
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
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    [self.searchTableView registerClass:[LCYSearchUserCell class] forCellReuseIdentifier:NSStringFromClass([LCYSearchUserCell class])];
    [self.searchTableView setSeparatorColor:[UIColor blackColor]];
    
    self.historyRecordTableView.backgroundColor = [UIColor redColor];
    self.historyRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, 300, 180) style:UITableViewStylePlain];
    self.historyRecordTableView.dataSource = self;
    self.historyRecordTableView.delegate = self;
    [self.historyRecordTableView registerClass:[LCYHistoryRecordCell class] forCellReuseIdentifier:NSStringFromClass([LCYHistoryRecordCell class])];
    [self.historyRecordTableView setSeparatorColor:[UIColor blackColor]];
    
    self.searchOptionsTableView = [[UITableView alloc] init];
    self.searchOptionsTableView.dataSource = self;
    self.searchOptionsTableView.delegate = self;
    [self.searchOptionsTableView registerClass: [LCYSearchOptionsCell class] forCellReuseIdentifier:NSStringFromClass([LCYSearchOptionsCell class])];
    [self.searchOptionsTableView setSeparatorColor:[UIColor blackColor]];
    [self.view addSubview:self.searchOptionsTableView];
    [self.searchOptionsTableView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).mas_offset(180);
        make.height.equalTo(self.view.mas_height);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width);
    }];
    self.searchOptionsTableView.hidden = YES;
    
    [self.view addSubview:self.historyRecordTableView];
    [self.historyRecordTableView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).mas_offset(180);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-50);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:self.historyRecordTableView]) {
        return self.historyRecordViewModel.historyRecordModel.historyRecordArray.count;
    } else if ([tableView isEqual:self.searchOptionsTableView]) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.historyRecordTableView]) {
        LCYHistoryRecordCell *historyRecordCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYHistoryRecordCell class]) forIndexPath:indexPath];
        historyRecordCell.backgroundColor = [UIColor whiteColor];
        historyRecordCell.selectionStyle = UITableViewScrollPositionNone;
        if (self.historyRecordViewModel.historyRecordModel.historyRecordArray.count > indexPath.row) {
            [historyRecordCell updateWithPlist:self.historyRecordViewModel.historyRecordModel.historyRecordArray[indexPath.row]];
        }
        return historyRecordCell;
    } else if ([tableView isEqual:self.searchOptionsTableView]) {
        LCYSearchOptionsCell *searchOptionsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYSearchOptionsCell class]) forIndexPath:indexPath];
        searchOptionsCell.backgroundColor = [UIColor whiteColor];
        searchOptionsCell.selectionStyle = UITableViewScrollPositionNone;
        if (5 > indexPath.row) {
            [searchOptionsCell updateWithString:self.searchTextField.text indexPath:indexPath.row];
        }
        return searchOptionsCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.historyRecordTableView]) {
        self.searchTextField.text = self.historyRecordViewModel.historyRecordModel.historyRecordArray[indexPath.row];
    } else if ([tableView isEqual:self.searchOptionsTableView]) {
        switch (indexPath.row) {
            case 0: {
                LCYSearchRepositoriesViewController *searchRepositoriesViewController = [[LCYSearchRepositoriesViewController alloc] init];
                [searchRepositoriesViewController setSearchText:self.searchTextField.text];
                [self.navigationController pushViewController:searchRepositoriesViewController animated:YES];
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
                [searchUserViewController setSearchText:self.searchTextField.text];
                [self.navigationController pushViewController:searchUserViewController animated:YES];
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
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPat
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.searchViewModel.userInfo removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
