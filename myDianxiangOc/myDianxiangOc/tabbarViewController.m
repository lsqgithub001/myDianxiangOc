//
//  tabbarViewController.m
//  myDianxiangOc
//
//  Created by 灰常溜 on 2019/7/24.
//  Copyright © 2019 灰常溜. All rights reserved.
//

#import "tabbarViewController.h"
#import "indexViewController.h"
#import "boxViewController.h"
#import "statisticsViewController.h"
#import "mineViewController.h"
@interface tabbarViewController ()

@end

@implementation tabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化两个视图控制器
    indexViewController *oneVc = [[indexViewController alloc]init];
    boxViewController *twoVc = [[boxViewController alloc]init];
    statisticsViewController *threeVc = [[statisticsViewController alloc]init];
    mineViewController *fourVc =[[mineViewController alloc]init];
    
    //为两个视图控制器添加导航栏控制器
    UINavigationController *navOne = [[UINavigationController alloc]initWithRootViewController:oneVc];
    UINavigationController *navTwo = [[UINavigationController alloc]initWithRootViewController:twoVc];
     UINavigationController *navThree = [[UINavigationController alloc]initWithRootViewController:threeVc];
     UINavigationController *navFour = [[UINavigationController alloc]initWithRootViewController:fourVc];
    
    //设置控制器文字
    navOne.title = @"首页";
    navTwo.title = @"配电箱";
     navThree.title = @"用电统计";
     navFour.title = @"我的";
    
    //设置控制器图片(使用imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal,不被系统渲染成蓝色)
    navOne.tabBarItem.image = [[UIImage imageNamed:@"tab_icon_home_default"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navOne.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_icon_home_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navTwo.tabBarItem.image = [[UIImage imageNamed:@"tab_icon_elect_default"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navTwo.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_icon_elect_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navThree.tabBarItem.image = [[UIImage imageNamed:@"tab_icon_box_default"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navThree.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_icon_box_active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFour.tabBarItem.image = [[UIImage imageNamed:@"tab_icon_mine_default"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFour.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_icon_mine_default(1)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //改变tabbarController 文字选中颜色(默认渲染为蓝色)
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRed:253/255.0 green:71/255.0 blue:157/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    //创建一个数组包含四个导航栏控制器
   // NSArray *vcArry = [NSArray arrayWithObjects:navOne,navTwo,navThree,navFour];
    
    //将数组传给UITabBarController
    self.viewControllers = @[navOne,navTwo,navThree,navFour];
    
    
}



@end
