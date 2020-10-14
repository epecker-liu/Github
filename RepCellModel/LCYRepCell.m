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

@interface LCYRepCell()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImage *image;

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

#pragma mark - init subView

- (void)initSubView
{
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(50);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.image = [[UIImage alloc] init];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark - update with Model

- (void)updateWithModel:(LCYItemModel *)model
{
    self.label.text = model.fullName;
    self.imageView.image = [self getImageFromURL:model.owner.imageUrl];
}

#pragma mark - get image from url

-(UIImage *)getImageFromURL:(NSString *)imageURL
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    //是否需要对返回结果做判断？
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
