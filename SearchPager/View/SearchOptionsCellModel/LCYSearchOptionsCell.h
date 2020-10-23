//
//  LCYSearchOptionsCellTableViewCell.h
//  GitHub
//
//  Created by bytedance on 2020/10/22.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchOptionsCell : UITableViewCell

- (void)updateWithString:(NSString *)searchString indexPath:(NSInteger)indexPath;

@end

NS_ASSUME_NONNULL_END
