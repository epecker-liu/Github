//
//  MyWorkData.m
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYMyWorkData.h"

@implementation LCYMyWorkData

- (instancetype)initWithWorkName:(NSString *)workName WorkImage:(UIImage *)workImage
{
    if (self = [super init]) {
        self.workName = workName;
        self.workImage = workImage;
    }
    return self;
}

@end
