//
//  MyWorkData.m
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MyWorkData.h"

@implementation MyWorkData

- (MyWorkData *)initWithWorkName:(NSString *)workName andWorkImage:(UIImage *)workImage
{
    if (self = [super init]) {
        self.workName = workName;
        self.workImage = workImage;
    }
    return self;
}

@end
