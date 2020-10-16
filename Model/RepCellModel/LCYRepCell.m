//
//  LCYRepCellTableViewCell.m
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYRepCell.h"
#import <Masonry.h>
#import "LCYItemModel.h"
#import <UIKit/UIKit.h>
#import "LCYUserModel.h"
#import <SDWebImage.h>

@interface LCYRepCell()

@property (nonatomic, strong) UILabel *githubProjectNameLabel;
@property (nonatomic, strong) UIImage *ownerAvatarImage;

@end

@implementation LCYRepCell

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
    self.githubProjectNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.githubProjectNameLabel];
    [self.githubProjectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(50);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.ownerAvatarImage = [[UIImage alloc] init];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark - Model

- (void)updateWithModel:(LCYItemModel *)model
{
    self.githubProjectNameLabel.text = model.fullName;
    //self.imageView.image = [self p_getImageFromURL:model.owner.imageUrl];
    [self.imageView sd_setImageWithURL:model.owner.imageUrl];
}

//#pragma mark - Private
//
//-(UIImage *)p_getImageFromURL:(NSString *)imageURL
//{
//    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
//    //是否需要对返回结果做判断？
//    UIImage *image = [UIImage imageWithData:data];
//    return image;
//}

@end
