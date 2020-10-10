//
//  HomePagerViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "HomePagerViewController.h"
#import "MyWorkData.h"
#import <Masonry/Masonry.h>

@interface HomePagerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *workData;
@property (nonatomic, strong) UILabel *myWorkLabel;
@property (nonatomic, strong) UILabel *favoritesLabel;
@property (nonatomic, strong) UILabel *recentLabel;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *myWorkTable;

@end

@implementation HomePagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

#pragma mark --initData

- (void)initData
{
    self.workData = [[NSMutableArray alloc] init];
    MyWorkData *myWorkData[4];
    NSArray *workNames = @[@"Issues",@"Pull Requests",@"Repositories",@"Organizations"];
    UIImage *workImages[4];
    workImages[0] = [UIImage imageNamed:@"Issues.png"];
    workImages[1] = [UIImage imageNamed:@"pull_requests.png"];
    workImages[2] = [UIImage imageNamed:@"Repositories"];
    workImages[3] = [UIImage imageNamed:@"Organizations.png"];
    for(int i = 0; i < 4; i++){
        myWorkData[i] = [[MyWorkData alloc] initWithWorkName:workNames[i] andWorkImage:workImages[i]];
        [self.workData addObject:myWorkData[i]];
    }
}

#pragma mark --initUI

- (void) initUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.view addSubview: self.myWorkLabel];
    [self.view addSubview: self.favoritesLabel];
    [self.view addSubview: self.editButton];
    [self.view addSubview: self.addButton];
    [self.view addSubview: self.recentLabel];
    [self.view addSubview: self.myWorkTable];
    [self.view addSubview: self.myWorkTable];
    [self setConstraints];
}

#pragma mark --set constraints

- (void) setConstraints{
    [self.myWorkLabel mas_makeConstraints:^ (MASConstraintMaker *make){
//        make.left.mas_equalTo(self.view.mas_left);
//        make.top.mas_equalTo(self.view.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(120, 60));
        make.top.mas_equalTo(self.view).offset(120.f);
        make.left.mas_equalTo(self.view).offset(20.f);
    }];
    
    [self.myWorkTable mas_makeConstraints:^ (MASConstraintMaker *make){
        //make.top.mas_equalTo(self.myWorkLabel.mas_bottom);
        //make.bottom.mas_equalTo(self.myWorkLabel.mas_bottom).offset(190);
    }];
    
}

#pragma mark --init view

- (UILabel *)myWorkLabel
{
    if(!_myWorkLabel){
        _myWorkLabel = [[UILabel alloc] init];
        _myWorkLabel.text = @"My Work";
        _myWorkLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _myWorkLabel;
}

- (UILabel *)favoritesLabel
{
    if(!_favoritesLabel){
        _favoritesLabel = [[UILabel alloc] init];
        _favoritesLabel.text = @"Favorites";
    }
    return _favoritesLabel;
}

- (UIButton *)editButton
{
    if(!_editButton){
        _editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    return _editButton;
}

- (UIButton *)addButton{
    if(!_addButton){
        _addButton = [[UIButton alloc] init];
        [_addButton setTitle:@"add" forState:UIControlStateNormal];
    }
    return _addButton;
}

- (UILabel *)recentLabel
{
    if(!_recentLabel){
        _recentLabel = [[UILabel alloc] init];
        _recentLabel.text = @"Recent";
    }
    return _recentLabel;
}

- (UITableView *)myWorkTable
{
    if(!_myWorkTable){
        _myWorkTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
        _myWorkTable.dataSource = self;
        _myWorkTable.delegate = self;
        [_myWorkTable setSeparatorColor:[UIColor blackColor]];
    }
    return _myWorkTable;
}
// 每个 Section 中的 Cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSInteger numOfSelectedCell = indexPath.row;
    MyWorkData *currentWorkData = _workData[numOfSelectedCell];
    cell.textLabel.text = currentWorkData.workName;
    cell.imageView.image = currentWorkData.workImage;
    cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    return cell;
}

@end
