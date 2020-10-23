//
//  LCYHistoryRecordCell.m
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYHistoryRecordCell.h"
#import <Masonry/Masonry.h>
#import <NSUserDefaults+RACSupport.h>

@interface LCYHistoryRecordCell()

@property (nonatomic, strong) UILabel *historyRecordLabel;

@end

@implementation LCYHistoryRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.historyRecordArray = [[NSArray alloc] init];
        //        [self getHistoryRecordFromPlist];
                [self initSubView];
    }
    return self;
}

#pragma mark - UI

- (void)initSubView{
    self.historyRecordLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.historyRecordLabel];
    [self.historyRecordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark - Model

- (void)updateWithPlist:(NSString *)historyRecordLabel
{
    self.historyRecordLabel.text = historyRecordLabel;
}

@end
