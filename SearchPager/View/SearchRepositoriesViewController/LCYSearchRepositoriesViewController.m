//
//  LCYSearchRepositoriesViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/23.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesViewController.h"

@interface LCYSearchRepositoriesViewController ()

@property (nonatomic, strong) UICollectionView *searchRepositoriesCollectionView;

@end

@implementation LCYSearchRepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    self.searchRepositoriesCollectionView = [[UICollectionView alloc] init];
    self.searchRepositoriesCollectionView.delegate = self;
    self.searchRepositoriesCollectionView.dataSource = self;
    
}

@end
