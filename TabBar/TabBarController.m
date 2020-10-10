//
//  TabBarController.m
//  GitHub
//
//  Created by bytedance on 2020/10/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "HomePagerViewController.h"
#import "TabBarController.h"
#import "NotificationViewController.h"
#import "SearchViewController.h"

@interface TabBarController ()<UITabBarDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Home";
    self.navigationItem.hidesBackButton = YES;
    
    HomePagerViewController *homePagerVC = [[HomePagerViewController alloc] init];
    [self addItemBar:homePagerVC andImage:@"home.png" andImageSelected:@"home_selected.png" andTitle:@"Home"];
    
    NotificationViewController *notificationPagerVC = [[NotificationViewController alloc] init];
    [self addItemBar:notificationPagerVC andImage:@"notifications.png" andImageSelected:@"notifications_selected.png" andTitle:@"Notifications"];

    SearchViewController *searchPagerVC = [[SearchViewController alloc] init];
    [self addItemBar:searchPagerVC andImage:@"search.png" andImageSelected:@"search_selected.png" andTitle:@"search"];
}

- (void)addItemBar:(UIViewController *)viewController andImage:(NSString *)imageName andImageSelected:(NSString *)image_sele andTitle:(NSString *)title
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
