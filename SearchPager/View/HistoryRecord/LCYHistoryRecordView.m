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

@interface LCYHistoryRecordView()

@property (nonatomic, strong) LCYHistoryRecordModel *historyRecordModel;
@property (nonatomic, strong) LCYHistoryRecordViewModel *historyRecordViewModel;

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
        // 接收键盘显示隐藏的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        // UI搭建
        [self initHistoryRecordUI];
    }
    return self;
}

- (void)initHistoryRecordUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.historyRecordTableView.backgroundColor = [UIColor redColor];
    self.historyRecordTableView = [[UITableView alloc] init];
    self.historyRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, 300, 180) style:UITableViewStylePlain];
    self.historyRecordTableView.dataSource = self;
    self.historyRecordTableView.delegate = self;
    [self.historyRecordTableView registerClass:[LCYHistoryRecordCell class] forCellReuseIdentifier:NSStringFromClass([LCYHistoryRecordCell class])];
    [self.historyRecordTableView setSeparatorColor:[UIColor blackColor]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyRecordViewModel.historyRecordModel.historyRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    LCYHistoryRecordCell *historyRecordCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LCYHistoryRecordCell class]) forIndexPath:indexPath];
    historyRecordCell.backgroundColor = [UIColor redColor];
    historyRecordCell.selectionStyle = UITableViewScrollPositionNone;
    if (self.historyRecordViewModel.historyRecordModel.historyRecordArray.count > indexPath.row) {
        [historyRecordCell updateWithPlist:self.historyRecordViewModel.historyRecordModel.historyRecordArray[indexPath.row]];
    }
    return historyRecordCell;
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPat
{
    return UITableViewCellEditingStyleDelete;
}

@end
