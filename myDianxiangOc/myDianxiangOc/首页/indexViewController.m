//
//  indexViewController.m
//  myDianxiangOc
//
//  Created by 灰常溜 on 2019/7/24.
//  Copyright © 2019 灰常溜. All rights reserved.
//

#import "indexViewController.h"

#import "text.h"
@interface indexViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation indexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // self.automaticallyAdjustsScrollViewInsets = NO;
    
    //  self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    //    UIView *v=  [[[NSBundle mainBundle] loadNibNamed:@"myIndexhead" owner:nil options:nil] lastObject];
    
    self.myTableView.scrollEnabled = false;
    
    self.navigationController.navigationBar.hidden = true;
    
    UIView *v=  [[[NSBundle mainBundle] loadNibNamed:@"text" owner:nil options:nil] lastObject];
    
    v.frame = CGRectMake(0, 0, kScreenWidth, kScale_W(667-49 - 20));
    
    UIView *v1= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScale_W(667-49 - 20))];
    
    [v1 addSubview:v];
    
    self.myTableView.tableHeaderView = v1;
    
    
    
    
    // self.myTableView.tableHeaderView.userInteractionEnabled = true;
    
    // v.bounds = CGRectMake(0, 0, kScreenWidth, 0);
    
    NSLog(@"%lf  -- %lf   --- %lf",kScale_H(667-49),kScreenHeight,kScale_W(667-47));
    
    // v1.height = 667-49;
    
    //    [self.myTableView beginUpdates];
    
    [self.myTableView setTableHeaderView:v1];
    
    //    [self.myTableView endUpdates];
    
    //  self.myTableView.tableHeaderView.backgroundColor = [UIColor redColor];
    
    //self.myTableView.tableHeaderView = v;
    
    // [self.myTableView.tableHeaderView layoutIfNeeded];
    
    self.myTableView.tableFooterView = [UIView new];
    
    //   v1.userInteractionEnabled = true;
    //   v.userInteractionEnabled = true;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *c = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
    c.textLabel.text = @"123123123123123123123123123123123123123123";
    c.contentView.backgroundColor = [UIColor grayColor];
    return c;
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0;
//}
@end
