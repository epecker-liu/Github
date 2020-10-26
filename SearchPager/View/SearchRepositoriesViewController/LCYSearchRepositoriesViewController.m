//
//  LCYSearchRepositoriesViewController.m
//  GitHub
//
//  Created by bytedance on 2020/10/23.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesViewController.h"
#import "LCYSearchRepositoriesCell.h"
#import "LCYSearchRepositoriesViewModel.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LCYSearchRepoModel.h"

@interface LCYSearchRepositoriesViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *searchRepositoriesCollectionView;
@property (nonatomic, strong) LCYSearchRepositoriesCell *searchRepositoriesCell;
@property (nonatomic, strong) LCYSearchRepositoriesViewModel *searchRepositoriesViewModel;
@property (nonatomic, strong) LCYSearchRepoModel *repoModel;
@property (nonatomic, strong) NSString *searchTextString;

@end

@implementation LCYSearchRepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchRepositoriesViewModel = [[LCYSearchRepositoriesViewModel alloc] init];
    [self bindViewModel];
    [self initData];
    [self initUI];
    [self.searchRepositoriesViewModel fetchRepositoriesInfo:self.searchTextString];
}


- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(self.searchRepositoriesViewModel, repositoriesInfo) subscribeNext:^ (id x){
        @strongify(self);
        [self.searchRepositoriesCollectionView reloadData];
    }];
}

- (void)setSearchText:(NSString *)searchText
{
    self.searchTextString = [[NSString alloc] init];
    self.searchTextString = searchText;
}

 - (void)initData
{
    [self.searchRepositoriesViewModel fetchRepositoriesInfo:self.searchTextString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *plistRecord = [defaults arrayForKey:@"historyRecord"];
    NSMutableArray *historyRecord = [NSMutableArray arrayWithArray:plistRecord];
    //去重
    [historyRecord removeObject:self.searchTextString];
    [historyRecord addObject:self.searchTextString];
    //持久化
    [defaults setObject:historyRecord forKey:@"historyRecord"];
    [defaults synchronize];
}

- (void)initUI
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 1);
    self.searchRepositoriesCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.searchRepositoriesCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchRepositoriesCollectionView];
    [self.searchRepositoriesCollectionView registerClass:[LCYSearchRepositoriesCell class] forCellWithReuseIdentifier:NSStringFromClass([LCYSearchRepositoriesCell class])];
    //    [self.searchRepositoriesCollectionView registerClass:[LCYSearchRepositoriesCell class] forCellWithReuseIdentifier:[LCYSearchRepositoriesCell class]];
    [self.searchRepositoriesCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.searchRepositoriesCollectionView mas_updateConstraints:^ (MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(90);
        make.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_width);
        make.centerX.mas_equalTo(self.view);
    }];
    self.searchRepositoriesCollectionView.delegate = self;
    self.searchRepositoriesCollectionView.dataSource = self;
}


#pragma mark -- UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchRepositoriesViewModel.totalCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    LCYSearchRepositoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCYSearchRepositoriesCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (self.searchRepositoriesViewModel.repositoriesInfo.count > indexPath.row) {
        [cell updateWithModel:self.searchRepositoriesViewModel.repositoriesInfo[indexPath.row]];
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchRepositoriesViewModel.repositoriesInfo.count > indexPath.row) {
        LCYSearchRepositoriesModel *curModel = self.searchRepositoriesViewModel.repositoriesInfo[indexPath.row];
        return CGSizeMake(self.view.bounds.size.width,
                          [self heightForString:curModel.descriptionRepositories fontSize:14 andWidth:self.view.bounds.size.width]);
        
    }
    return CGSizeMake(self.view.bounds.size.width, 50);
}

- (float) heightForString:(NSString *)value fontSize: (float)fontSize andWidth:(float)width
{
    CGSize infoSize = CGSizeMake(self.view.frame.size.width, 1000);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:17.f ]};
    CGRect infoRect =   [value boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return ceil(infoRect.size.height) + 52.0;
}

@end
