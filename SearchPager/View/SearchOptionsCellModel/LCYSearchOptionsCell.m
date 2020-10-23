//
//  LCYSearchOptionsCellTableViewCell.m
//  GitHub
//
//  Created by bytedance on 2020/10/22.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchOptionsCell.h"
#import <Masonry/Masonry.h>

@interface LCYSearchOptionsCell()

@property (nonatomic, strong) UILabel *searchOptionsLabel;

@end

@implementation LCYSearchOptionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    self.searchOptionsLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.searchOptionsLabel];
    [self.searchOptionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark - Model

- (void)updateWithString:(NSString *)searchString indexPath:(NSInteger)indexPath
{
    switch (indexPath) {
        case 0:
            self.searchOptionsLabel.text = [NSString stringWithFormat:@"包含\"%@\"的仓库", searchString];
            break;
        case 1:
            self.searchOptionsLabel.text = [NSString stringWithFormat:@"包含\"%@\"的议题", searchString];
            break;
        case 2:
            self.searchOptionsLabel.text = [NSString stringWithFormat:@"包含\"%@\"的拉取请求", searchString];
            break;
        case 3:
            self.searchOptionsLabel.text = [NSString stringWithFormat:@"包含\"%@\"的人员", searchString];
            break;
        case 4:
            self.searchOptionsLabel.text = [NSString stringWithFormat:@"包含\"%@\"的组织", searchString];
            break;
        default:
            break;
    }
}


@end
