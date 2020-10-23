//
//  LCYSearchRepositoriesViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/23.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchUserViewController.h"
#import "LCYSearchUserCell.h"
#import <Masonry/Masonry.h>
#import "LCYSearchUserViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LCYSearchUserViewController ()

@property (nonatomic, strong) UITableView *searchRepositoriesTableView;
@property (nonatomic, strong) LCYSearchUserViewModel *searchViewModel;
@property (nonatomic, strong) NSString *searchTextString;

@end

@implementation LCYSearchUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.searchTextString = [[NSString alloc] init];
    self.searchViewModel = [[LCYSearchUserViewModel alloc] init];
    [self bindViewModel];
    [self initData];
    [self initUI];
    [self.searchViewModel fetchUsersInfo:self.searchTextString];
}

- (void)setSearchText:(NSString *)searchText
{
    self.searchTextString = [[NSString alloc] init];
    self.searchTextString = searchText;
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
        [self.searchRepositoriesTableView reloadData];
    }];
}

 - (void)initData
{
    [self.searchViewModel fetchUsersInfo:self.searchTextString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *plistRecord = [defaults arrayForKey:@"historyRecord"];
    NSMutableArray *historyRecord = [NSMutableArray arrayWithArray:plistRecord];
    //去重
    [historyRecord removeObject:self.searchTextString];
    [historyRecord addObject:self.searchTextString];
    //持久化
    [defaults setObject:historyRecord forKey:@"historyRecord"];
    [defaults synchronize];
    NSLog(@"plist ---- -%@", [defaults arrayForKey:@"historyRecord"]);    // test 完成后删除
}


#pragma  mark - UI

- (void)initUI
{
    self.searchRepositoriesTableView = [[UITableView alloc] init];
    self.searchRepositoriesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
    self.searchRepositoriesTableView.dataSource = self;
    self.searchRepositoriesTableView.delegate = self;
    [self.searchRepositoriesTableView registerClass:[LCYSearchUserCell class] forCellReuseIdentifier:NSStringFromClass([LCYSearchUserCell class])];
    [self.searchRepositoriesTableView setSeparatorColor:[UIColor blackColor]];
    [self.view addSubview:self.searchRepositoriesTableView];
    [self.searchRepositoriesTableView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.view.mas_top);
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
    LCYSearchUserCell *searchUserCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYSearchUserCell class]) forIndexPath:indexPath];
    searchUserCell.backgroundColor = [UIColor whiteColor];
    searchUserCell.selectionStyle = UITableViewScrollPositionNone;
    if (self.searchViewModel.userInfo.count > indexPath.row) {
        [searchUserCell updateWithModel:self.searchViewModel.userInfo[indexPath.row]];
    }
    return searchUserCell;
}

@end
