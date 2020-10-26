//
//  LCYShowRepOfNetControllerViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYShowRepositoriesViewController.h"
#import "LCYFetchNetDataService.h"
#import <Masonry/Masonry.h>
#import "LCYRepoCell.h"
#import "LCYMyWorkData.h"
#import <MJRefresh/MJRefresh.h>
#import <MTLModel.h>
#import "LCYItemModel.h"
#import <SDWebImage/SDWebImage.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LCYRepositoriesViewModel.h"

@interface LCYShowRepositoriesViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) NSInteger *lineNum;
@property (nonatomic, strong) NSMutableArray *workData;
@property (nonatomic, strong) UITableView *repositoriesTableView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) LCYRepositoriesViewModel *fetchRepositoriesViewModel;
//@property (nonatomic, strong) LCYItemModel *githubProjectName;

@end

@implementation LCYShowRepositoriesViewController
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fetchRepositoriesViewModel = [[LCYRepositoriesViewModel alloc] init];
    [self initUI];
    [self bindViewModel];
    [self.fetchRepositoriesViewModel fetchRepositories];
}

- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(self.fetchRepositoriesViewModel, repositoriesList) subscribeNext:^ (id x){
        @strongify(self);
        [self.repositoriesTableView reloadData];
    }];
}

#pragma mark - init UI

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.repositoriesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
    self.repositoriesTableView.dataSource = self;
    self.repositoriesTableView.delegate = self;
    [self.repositoriesTableView registerClass:[LCYRepoCell class] forCellReuseIdentifier:NSStringFromClass([LCYRepoCell class])];
    [self.repositoriesTableView setSeparatorColor:[UIColor blackColor]];
    
    self.editButton = [[UIButton alloc] init];
    self.editButton.backgroundColor = [UIColor blackColor];
    [self.editButton setTitle:@"edit" forState:UIControlStateNormal];
    [self.editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.editButton.layer.cornerRadius = 6;
    [self.editButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    
    //左滑删除
    self.repositoriesTableView.allowsMultipleSelection = NO;
    self.repositoriesTableView.allowsSelectionDuringEditing = NO;
    self.repositoriesTableView.allowsMultipleSelectionDuringEditing = NO;
    self.repositoriesTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchRepositories)];
    self.repositoriesTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchRepositories)];
    
    [self.view addSubview:self.repositoriesTableView];
    [self.repositoriesTableView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(self.view.mas_height);
        make.width.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.editButton];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.width.mas_equalTo(40);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchRepositoriesViewModel.repositoriesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCYRepoCell *repCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYRepoCell class]) forIndexPath:indexPath];
    repCell.backgroundColor = [UIColor whiteColor];
    repCell.selectionStyle = UITableViewScrollPositionNone;
    if ([self.fetchRepositoriesViewModel.repositoriesList count] > indexPath.row) {
        [repCell updateWithModel:self.fetchRepositoriesViewModel.repositoriesList[indexPath.row]];
    }
    return repCell;
}

#pragma mark - UITableViewDeleagte

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPat
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.fetchRepositoriesViewModel.repositoriesList removeObjectAtIndex:indexPath.row];
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

- (void)edit
{
    [self.repositoriesTableView setEditing:!self.repositoriesTableView.editing];
}


- (void)fetchRepositories
{
    [self.fetchRepositoriesViewModel fetchRepositories];
    [self.repositoriesTableView.mj_header endRefreshing];
    [self.repositoriesTableView.mj_footer endRefreshing];
}

@end
