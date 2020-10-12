//
//  TabBarController.m
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYHomePagerViewController.h"
#import "LCYTabBarController.h"
#import "LCYNotificationViewController.h"
#import "LCYSearchViewController.h"

@interface LCYTabBarController ()<UITabBarDelegate>

@end

@implementation LCYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Home";
    self.navigationItem.hidesBackButton = YES;
    
    LCYHomePagerViewController *homePagerVC = [[LCYHomePagerViewController alloc] init];
    [self addItemBar:homePagerVC Image:@"home.png" ImageSelected:@"home_selected.png" Title:@"Home"];
    
    LCYNotificationViewController *notificationPagerVC = [[LCYNotificationViewController alloc] init];
    [self addItemBar:notificationPagerVC Image:@"notifications.png" ImageSelected:@"notifications_selected.png" Title:@"Notifications"];

    LCYSearchViewController *searchPagerVC = [[LCYSearchViewController alloc] init];
    [self addItemBar:searchPagerVC Image:@"search.png" ImageSelected:@"search_selected.png" Title:@"search"];
}

- (void)addItemBar:(UIViewController *)viewController Image:(NSString *)imageName ImageSelected:(NSString *)image_sele Title:(NSString *)title
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSelected = [[UIImage imageNamed:image_sele] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(46, 0, 30, 0);
    [viewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,20)];
    [viewController.tabBarItem initWithTitle:title image:image selectedImage:imageSelected];
    [self addChildViewController:viewController];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    self.navigationItem.title = item.title;
}

@end
