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
@property (weak, nonatomic) IBOutlet UITextField *myPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


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
    
    self.loginBtn.enabled = false;
    
    
    //[[IQKeyboardManager sharedManager] setEnable:YES];
    
    self.viewHeig.constant = kScale_H(286);
    
    /*
     将TextField的输入转化为信号量
     */
    RACSignal *userNameSignal = self.myPhone.rac_textSignal;
    RACSignal *psdSignal = self.myPassword.rac_textSignal;
    /*
     合并两个输入框的信号量，并使用map对信号量返回值进行映射使其返回bool值，
     */
    RACSignal *bigSignal = [[RACSignal combineLatest:@[userNameSignal,psdSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        RACTupleUnpack(NSString *username , NSString *psd) = value;
        
        if([username length] == 11 && [psd length]>=6)
        {
            self.loginBtn.backgroundColor =   [UIColor colorWithRed:253/255.0 green:71/255.0 blue:157/255.0 alpha:1.0];
        }else
        {
            self.loginBtn.backgroundColor = [UIColor colorWithRed:254/255.0 green:181/255.0 blue:216/255.0 alpha:1.0];
       }
        
        //@()将值变量装箱成对象
        return @([username length] == 11 && [psd length]>=6);
    }];
    /*
     使用RAC将一个信号量绑定在一个属性上
     */
    
    RAC(self.loginBtn, enabled) = bigSignal;
    
    
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

#pragma 正则匹配手机号
- (BOOL)checkTelNumber:(NSString*) telNumber
{
     NSString *pattern =@"^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[189])\\d{8}$";;
    
      NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
      BOOL isMatch = [pred evaluateWithObject:telNumber];
    
      return isMatch;
    
}

- (IBAction)loginAct:(id)sender {
    
//    NSLog(@"%@",self.myPassword.text);
   if (![self checkTelNumber:self.myPhone.text])
    if(![self validateCellPhoneNumber:self.myPassword.text])
    {//不通过
        [QMUITips showError:@"登陆失败" detailText:@"输入正确手机号码" inView:self.view hideAfterDelay:1];
        
    }else{
        
    }
    
}

- (BOOL)validateCellPhoneNumber:(NSString *)cellNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:cellNum] == YES)
       || ([regextestcm evaluateWithObject:cellNum] == YES)
       || ([regextestct evaluateWithObject:cellNum] == YES)
       || ([regextestcu evaluateWithObject:cellNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

@end
