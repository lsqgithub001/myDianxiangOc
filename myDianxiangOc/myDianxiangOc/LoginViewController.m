//
//  LoginViewController.m
//  myDianxiangOc
//
//  Created by 灰常溜 on 2019/7/23.
//  Copyright © 2019 灰常溜. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeig;

@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageEditing;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aspTitleHeig;

@property (weak, nonatomic) IBOutlet QMUIButton *registerBtn;


@property (weak, nonatomic) IBOutlet QMUITextField *myPhone;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    self.titleImageEditing.hidden = true;
    
    //[[IQKeyboardManager sharedManager] setEnable:YES];
    
    self.viewHeig.constant = kScale_H(286);
    
    
}

-(void)keyboardWillShow
{
   
    [UIView animateWithDuration:1 animations:^{

        self.viewHeig.constant = kScale_H(138);
        
         self.myTitle.hidden = true;
       
         self.titleImageEditing.hidden = false;
        
         self.titleImage.hidden = true;
        
        [self.view layoutIfNeeded];
    }];
    
}


-(void)keyboardWillHide
{
    [UIView animateWithDuration:1 animations:^{
        

        self.viewHeig.constant = kScale_H(286);
        self.myTitle.hidden = false;
      
        self.titleImageEditing.hidden = true;
        
        self.titleImage.hidden = false;
        
          [self.view layoutIfNeeded];
    }];
}



@end
