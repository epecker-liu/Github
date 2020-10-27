//
//  LCYHistoryRecordView.m
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYHistoryRecordView.h"
#import "LCYHistoryRecordCell.h"
#import "LCYHistoryRecordModel.h"
#import "LCYHistoryRecordViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
#import "LCYConstValue.h"

@interface LCYHistoryRecordView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) LCYHistoryRecordModel *historyRecordModel;
@property (nonatomic, strong) LCYHistoryRecordViewModel *historyRecordViewModel;
@property (nonatomic, strong) UITableView *historyRecordTableView;

@end

@implementation LCYHistoryRecordView

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (instancetype) init
{
    if (self = [super init]) {
//         接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//         UI搭建
        self.historyRecordViewModel = [[LCYHistoryRecordViewModel alloc] init];
        self.searchString = [[NSString alloc] init];
        [self initHistoryRecordUI];
    }
    return self;
}

- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(self.searchString, length) subscribeNext:^ (id x){
        @strongify(self);
        [self.historyRecordTableView reloadData];
    }];
}



- (void)initHistoryRecordUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.historyRecordTableView = [[UITableView alloc] init];
    self.historyRecordTableView.backgroundColor = [UIColor whiteColor];
    self.historyRecordTableView.dataSource = self;
    self.historyRecordTableView.delegate = self;
    [self.historyRecordTableView registerClass:[LCYHistoryRecordCell class] forCellReuseIdentifier:NSStringFromClass([LCYHistoryRecordCell class])];
    [self.historyRecordTableView setSeparatorColor:[UIColor blackColor]];
    [self addSubview:self.historyRecordTableView];
    [self.historyRecordTableView mas_makeConstraints:^ (MASConstraintMaker *make){
        make.top.equalTo(self.mas_top);
        make.height.equalTo(self.mas_height);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyRecordViewModel.historyRecordModel.historyRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCYHistoryRecordCell *historyRecordCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYHistoryRecordCell class]) forIndexPath:indexPath];
    historyRecordCell.backgroundColor = [UIColor whiteColor];
    historyRecordCell.selectionStyle = UITableViewScrollPositionNone;
    if (self.historyRecordViewModel.historyRecordModel.historyRecordArray.count > indexPath.row) {
        [historyRecordCell updateWithModel:self.historyRecordViewModel.historyRecordModel.historyRecordArray[indexPath.row]];
    }
    return historyRecordCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    self.searchString = self.historyRecordViewModel.historyRecordModel.historyRecordArray[indexPath.row];
}

- (void)updateSearchString:(NSString *)searchString
{
    if (searchString.length == 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.historyRecordViewModel.historyRecordModel.historyRecordArray = [defaults arrayForKey:kLCYSearchHistoryRecordKey];
        [self.historyRecordTableView reloadData];
    }
}

@end
