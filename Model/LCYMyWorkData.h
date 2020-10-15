//
//  MyWorkData.h
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYMyWorkData : NSObject

@property (nonatomic, strong) NSString *workName;
@property (nonatomic, strong) UIImage *workImage;

- (instancetype)initWithWorkName: (NSString *)workName WorkImage:(UIImage *)workImage;

@end

NS_ASSUME_NONNULL_END
