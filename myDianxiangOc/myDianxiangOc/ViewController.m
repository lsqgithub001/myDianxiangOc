//
//  ViewController.m
//  myDianxiangOc
//
//  Created by 灰常溜 on 2019/7/23.
//  Copyright © 2019 灰常溜. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LoginViewController *l = [[LoginViewController alloc]init];
    
    [self presentViewController:l animated:false completion:nil];
}


@end
