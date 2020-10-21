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
#import "LCYSearchViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MJRefresh/MJRefresh.h>
#import "LCYSearchCellTableViewCell.h"

@interface LCYSearchViewController ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) LCYSearchViewModel *searchViewModel;
@property (nonatomic, strong) NSMutableArray *temp;
@property (nonatomic, strong) UITableView *searchTableView;

@end

@implementation LCYSearchViewController

- (void)viewDidLoad
{
    self.searchViewModel = [[LCYSearchViewModel alloc] init];
    [super viewDidLoad];
    [self bindViewModel];
    [self initSearchPageUI];
}

- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(self.searchViewModel, userInfo) subscribeNext:^ (id x){
           NSLog(@"observe search data success!");
        NSLog(@"userinfo ---- %@", self.searchViewModel.userInfo);
        NSLog(@"userinfo in fact have %lu array", self.searchViewModel.userInfo.count);
        NSLog(@"userinfo totalcount --- %lu", self.searchViewModel.totalCount);
           @strongify(self);
        [self.searchTableView reloadData];
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
    
    self.searchButton = [[UIButton alloc] init];
    self.searchButton.backgroundColor = [UIColor blackColor];
    [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchButton.layer.cornerRadius = 6;
    [self.searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.searchTextField.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.width.mas_equalTo(self.view.mas_width).mas_equalTo(-20);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    [self.searchTableView registerClass:[LCYSearchCellTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LCYSearchCellTableViewCell class])];
    [self.searchTableView setSeparatorColor:[UIColor blackColor]];
    
    //左滑删除
    self.searchTableView.allowsMultipleSelection = NO;
    self.searchTableView.allowsSelectionDuringEditing = NO;
    self.searchTableView.allowsMultipleSelectionDuringEditing = NO;
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchRepositories)];
    self.searchTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchRepositories)];
    
    [self.view addSubview:self.searchTableView];
    [self.searchTableView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.searchButton.mas_bottom).offset(10);
        make.height.mas_equalTo(self.view.mas_height);
        make.width.mas_equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchViewModel.totalCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    LCYSearchCellTableViewCell *searchCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYSearchCellTableViewCell class]) forIndexPath:indexPath];
    searchCell.backgroundColor = [UIColor whiteColor];
    searchCell.selectionStyle = UITableViewScrollPositionNone;
    if (self.searchViewModel.userInfo.count > indexPath.row) {
        [searchCell updateWithModel:self.searchViewModel.userInfo[indexPath.row]];
    }
    return searchCell;
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

#pragma mark - button event

- (void)search
{
    [self.searchViewModel fetchUsersInfo:self.searchTextField.text];
    [self.searchTableView.mj_header endRefreshing];
    [self.searchTableView.mj_footer endRefreshing];
}

@end
