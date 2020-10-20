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
#import <Mantle.h>
#import "LCYSearchModel.h"

static NSString *const kSearchAPIString = @"https://api.github.com/search/users?q=%@&access_token=b637fbc4c06bf2ff2bc7c9943ccfd17381f5ee4c";

@interface LCYSearchViewController ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) LCYFetchNetDataService *fetchNetDataService;
@property (nonatomic, strong) NSMutableArray *temp;

@end

@implementation LCYSearchViewController

- (void)viewDidLoad
{
    self.fetchNetDataService = [[LCYFetchNetDataService alloc] init];
    [super viewDidLoad];
    [self initSearchPageUI];
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
}

#pragma mark - button event

- (void)search
{
    NSString *searchURLString  = [NSString stringWithFormat:kSearchAPIString, self.searchTextField.text];
    NSLog(searchURLString);
    [self.fetchNetDataService fetchDateFromURL:searchURLString completion:^(NSMutableArray * _Nonnull data ,NSError * _Nonnull err){
        if (err) {
            NSLog(@"fail");
        } else {
            self.temp = [[NSMutableArray alloc] init];
//            for(int i = 0; i < [data count]; i++) {
//            LCYSearchModel *githubProjectName = [MTLJSONAdapter modelOfClass:[LCYSearchModel class] fromJSONDictionary:data error:nil];
            LCYSearchModel *searchItems = [MTLJSONAdapter modelsOfClass:[LCYSearchModel class] fromJSONArray:data error:nil];
            [self.temp addObject:searchItems.items];
//            }
            //[self.repositoriesTableView reloadData];
        }
        NSLog(@"temp ---- %@", self.temp);
//        [self.repositoriesTableView.mj_header endRefreshing];
//        [self.repositoriesTableView.mj_footer endRefreshing];
    }];
}

@end
