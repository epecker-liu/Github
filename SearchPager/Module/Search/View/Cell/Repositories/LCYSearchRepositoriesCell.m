//
//  LCYSearchRepositoriesCellCollectionViewCell.m
//  GitHub
//
//  Created by bytedance on 2020/10/23.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesCell.h"
#import <Masonry/Masonry.h>
#import "LCYSearchRepositoriesModel.h"
#import <SDWebImage/SDWebImage.h>

@interface LCYSearchRepositoriesCell()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *repositoriesNameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *sexLabel;

@end

@implementation LCYSearchRepositoriesCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
- (void)initSubView
{
    self.avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    self.userNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    
    self.sexLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.sexLabel];
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_left).offset(180);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    
    self.repositoriesNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.repositoriesNameLabel];
    [self.repositoriesNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(5);
    }];
    
    self.describeLabel = [[UILabel alloc] init];
    self.describeLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.describeLabel.numberOfLines = 0;
    [self.describeLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:self.describeLabel];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.top.mas_equalTo(self.repositoriesNameLabel.mas_bottom).offset(5);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.sexLabel.text = @"";
}

#pragma mark - Model

- (void)updateWithModel:(LCYSearchRepositoriesModel *)model
{
    self.userNameLabel.text = model.owner.userName;
    if (arc4random() % 2) {
        self.sexLabel.text = @"性别";
    }
    self.repositoriesNameLabel.text = model.repositioryName;
    self.describeLabel.text = model.descriptionRepositories;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.owner.avatarURL]];
}

@end
