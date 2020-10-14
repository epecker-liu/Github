//
//  LCYShowRepOfNetControllerViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYShowRepOfNetViewController.h"
#import "LCYFetchNetData.h"
#import <Masonry.h>
#import "LCYRepCell.h"
#import "LCYMyWorkData.h"
#import <MJRefresh.h>

@interface LCYShowRepOfNetViewController ()

@property(nonatomic, assign)NSInteger *lineNum;
@property(nonatomic, strong) NSMutableArray *workData;
@property(nonatomic, strong) UITableView *repOfNetTable;
@property(nonatomic, strong) NSMutableArray *repositoriesList;
@property(nonatomic, strong) UIButton *editButton;
@property(nonatomic, strong) LCYFetchNetData *fetchData;

@end

@implementation LCYShowRepOfNetViewController
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fetchData = [[LCYFetchNetData alloc] init];
    [self refresh];
    [self initUI];
}


#pragma mark - init UI

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self.view addSubview:self.repOfNetTable];
    [self.repOfNetTable mas_makeConstraints:^ (MASConstraintMaker *make){
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

#pragma mark - init view

- (void)initView{
    self.repOfNetTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
    self.repOfNetTable.dataSource = self;
    self.repOfNetTable.delegate = self;
    [self.repOfNetTable setSeparatorColor:[UIColor blackColor]];
    
    self.editButton = [[UIButton alloc] init];
    self.editButton.backgroundColor = [UIColor blackColor];
    [self.editButton setTitle:@"edit" forState:UIControlStateNormal];
    [self.editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.editButton.layer.cornerRadius = 6;
    [self.editButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    
    //左滑删除
    self.repOfNetTable.allowsMultipleSelection = NO;
    self.repOfNetTable.allowsSelectionDuringEditing = NO;
    self.repOfNetTable.allowsMultipleSelectionDuringEditing = NO;
    self.repOfNetTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.repOfNetTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
}

#pragma mark - set table cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repositoriesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.repOfNetTable registerClass:[LCYRepCell class] forCellReuseIdentifier:@"LCYRepCell"];
    LCYRepCell *repCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYRepCell class])];
    if(repCell == nil){
        repCell = [[LCYRepCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(LCYRepCell.class)];
    }
    repCell.backgroundColor = [UIColor whiteColor];
    repCell.selectionStyle = UITableViewScrollPositionNone;
    [repCell updateWithModel:self.repositoriesList[indexPath.row]];
    return repCell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPat
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.repositoriesList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
          return @"删除";
}

#pragma mark - button event

- (void)edit
{
    NSLog(@"edit button!");
    [self.repOfNetTable setEditing:!self.repOfNetTable.editing];
}

- (void)refresh
{
    [self.fetchData getData:@"https://api.github.com/users/epecker-liu/repos?access_token=8422dde55e216b768a54f8f4cc5f43c4a6dfbb7d" completion:^(NSMutableArray * _Nonnull data ,NSError * _Nonnull err){
        if(err){
            NSLog(@"fail");
        }else{
            self.repositoriesList = [[NSMutableArray alloc] init];
            self.repositoriesList = [data mutableCopy];
            [self.repOfNetTable reloadData];
        }
    }];
    [self.repOfNetTable.mj_header endRefreshing];
    [self.repOfNetTable.mj_footer endRefreshing];
}

@end
