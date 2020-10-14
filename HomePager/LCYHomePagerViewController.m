//
//  HomePagerViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYHomePagerViewController.h"
#import "LCYMyWorkData.h"
#import <Masonry/Masonry.h>
#import "LCYFetchNetData.h"
#import "LCYShowRepOfNetViewController.h"

@interface LCYHomePagerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *workData;
@property (nonatomic, strong) UILabel *myWorkLabel;
@property (nonatomic, strong) UILabel *favoritesLabel;
@property (nonatomic, strong) UILabel *recentLabel;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *myWorkTable;
@property (nonatomic, strong) UITableView *favoritesTable;
@property (nonatomic, strong) UITableView *recentTable;

@end

@implementation LCYHomePagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

#pragma mark - initData

- (void)initData
{
    self.workData = [[NSMutableArray alloc] init];
    LCYMyWorkData *myWorkData[4];
    NSArray *workNames = @[@"Issues",@"Pull Requests",@"Repositories",@"Organizations"];
    UIImage *workImages[4];
    workImages[0] = [UIImage imageNamed:@"Issues.png"];
    workImages[1] = [UIImage imageNamed:@"pull_requests.png"];
    workImages[2] = [UIImage imageNamed:@"Repositories"];
    workImages[3] = [UIImage imageNamed:@"Organizations.png"];
    for(int i = 0; i < 4; i++){
        myWorkData[i] = [[LCYMyWorkData alloc] initWithWorkName:workNames[i] WorkImage:workImages[i]];
        [self.workData addObject:myWorkData[i]];
    }
}

#pragma mark - initUI

- (void) initUI
{
    [self initView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.view addSubview: self.addButton];
    
    [self.view addSubview: self.myWorkLabel];
    [self.myWorkLabel mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.view).offset(120);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    
    [self.view addSubview: self.myWorkTable];
    [self.myWorkTable mas_makeConstraints:^ (MASConstraintMaker *make){
           make.top.mas_equalTo(self.myWorkLabel.mas_bottom);
           make.height.mas_equalTo(180);
           make.width.mas_equalTo(self.view);
       }];
    
    [self.view addSubview: self.favoritesLabel];
    [self.favoritesLabel mas_makeConstraints:^ (MASConstraintMaker *make){
          make.top.mas_equalTo(self.myWorkTable.mas_bottom).mas_offset(10);
          make.left.mas_equalTo(self.view).offset(20);
      }];
    
    [self.view addSubview: self.favoritesTable];
    [self.favoritesTable mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.favoritesLabel.mas_bottom);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(self.view);
    }];
    
    [self.view addSubview: self.editButton];
    [self.editButton mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.favoritesLabel.mas_top);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.favoritesLabel.mas_top);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self.view.mas_right).offset(-50);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
    }];
    
    [self.view addSubview: self.recentLabel];
    [self.recentLabel mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.favoritesTable.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    
    [self.view addSubview: self.recentTable];
    [self.recentTable mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.mas_equalTo(self.recentLabel.mas_bottom);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(self.view);
    }];
}

#pragma mark - init view

- (void)initView
{
    //set my work label
    self.myWorkLabel = [[UILabel alloc] init];
    self.myWorkLabel.text = @"My Work";
    self.myWorkLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    //set favorites label
    self.favoritesLabel = [[UILabel alloc] init];
    self.favoritesLabel.text = @"Favorites";
    self.favoritesLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];

    
    //set edit button
    self.editButton = [[UIButton alloc] init];
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    self.editButton.backgroundColor = [UIColor clearColor];
    [self.editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(click_edit) forControlEvents:UIControlEventTouchUpInside];

    //set add button
    self.addButton = [[UIButton alloc] init];
    [self.addButton setTitle:@"add" forState:UIControlStateNormal];

    //set recent label
    self.recentLabel = [[UILabel alloc] init];
    self.recentLabel.text = @"Recent";
    self.recentLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    //set my work table
    self.myWorkTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 180) style:UITableViewStylePlain];
    self.myWorkTable.dataSource = self;
    self.myWorkTable.delegate = self;
    [self.myWorkTable setSeparatorColor:[UIColor blackColor]];

    //set favorites table
    self.favoritesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 90) style:UITableViewStylePlain];
    self.favoritesTable.dataSource = self;
    self.favoritesTable.delegate = self;
    [self.favoritesTable setSeparatorColor:[UIColor blackColor]];

    //set recent table
    self.recentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 90) style:UITableViewStylePlain];
    self.recentTable.dataSource = self;
    self.recentTable.delegate = self;
    [self.recentTable setSeparatorColor:[UIColor blackColor]];
}

#pragma mark - set table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.myWorkTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    NSInteger numOfSelectedCell = indexPath.row;
    LCYMyWorkData *currentWorkData = _workData[numOfSelectedCell];
    cell.textLabel.text = currentWorkData.workName;
    cell.imageView.image = currentWorkData.workImage;
    cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    UIButton *respositoriesRequest = [UIButton buttonWithType:UIButtonTypeCustom];
    respositoriesRequest.frame = CGRectMake(0,0, 600, 45);
    respositoriesRequest.backgroundColor = [UIColor clearColor];
    [respositoriesRequest addTarget:self action:@selector(respositories:) forControlEvents:UIControlEventTouchUpInside];
    respositoriesRequest.tag = indexPath.row;
    [cell.contentView addSubview:respositoriesRequest];
    return cell;
}

#pragma mark --respositories request button

- (void) respositories:(UIButton *) button
{
    if(button.tag == 2){
        LCYShowRepOfNetViewController *showRepofNetViewController = [[LCYShowRepOfNetViewController alloc] init];
        [self.navigationController pushViewController:showRepofNetViewController animated:YES];
    }else{
        NSLog(@"tag not found!");
    }
}

@end
