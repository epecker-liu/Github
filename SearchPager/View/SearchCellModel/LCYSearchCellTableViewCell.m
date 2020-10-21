//
//  LCYSearchCellTableViewCell.m
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchCellTableViewCell.h"
#import <Masonry/Masonry.h>
#import "LCYSearchUserModel.h"
#import <SDWebImage/SDWebImage.h>

@interface LCYSearchCellTableViewCell ()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;

@end
@implementation LCYSearchCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

#pragma mark - UI

- (void)initSubView
{
    self.userNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(50);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark - Model

- (void)updateWithModel:(LCYSearchUserModel *)model
{
    self.userNameLabel.text = model.userName;
    //self.imageView.image = [self p_getImageFromURL:model.owner.imageUrl];
    //SD框架本身有imageView调用self.imageView的时候回导致没有图，应该使用自定义的self.ownerAvatarImageView.
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatarURL]];
}

@end
