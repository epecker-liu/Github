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

@interface LCYShowRepOfNetViewController ()

@property(nonatomic, assign)NSInteger *lineNum;
@property (nonatomic, strong) NSMutableArray *workData;
@property (nonatomic, strong) UITableView *repOfNetTable;
@property(nonatomic, copy) NSMutableArray *repositoriesList;

@end

@implementation LCYShowRepOfNetViewController
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    LCYFetchNetData *fetchData = [[LCYFetchNetData alloc] init];
    [fetchData getData:@"https://api.github.com/users/epecker-liu/repos?access_token=28ea1a6e82d662a5bd2091447afd895e0aa6d9e5" completion:^(NSMutableArray * _Nonnull data ,NSError * _Nonnull err){
        if(err){
            NSLog(@"fail");
        }else{
            self.repositoriesList = data;
            [self.repOfNetTable reloadData];
        }
    }];
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
}

#pragma mark - init view

- (void)initView{
    self.repOfNetTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
    self.repOfNetTable.dataSource = self;
    self.repOfNetTable.delegate = self;
    [self.repOfNetTable setSeparatorColor:[UIColor blackColor]];
}

#pragma mark - set table cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositoriesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

@end
