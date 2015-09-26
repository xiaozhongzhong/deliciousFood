//
//  resiveViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "resiveViewController.h"
#import "loginViewController.h"

@interface resiveViewController ()
- (IBAction)reserveAction:(UIBarButtonItem *)sender;


@end

@implementation resiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;

    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reserveAction:(UIBarButtonItem *)sender {
    NSString *username = _username.text;
    NSString *email = _email.text;
    NSString *password = self.password.text;
    NSString *confirmPwd = self.confirm.text;
    NSString *address = self.address.text;
    NSString *phoneNumber=self.phoneNumber.text;
<<<<<<< HEAD
   
    if ([username isEqualToString:@""]||[email isEqualToString:@""]||[password isEqualToString:@""]||[confirmPwd isEqualToString:@""]|| [address isEqualToString:@""]) {
=======
    NSInteger i=11;
    if ([username isEqualToString:@""]||[email isEqualToString:@""]||[password isEqualToString:@""]||[confirmPwd isEqualToString:@""]|| [address isEqualToString:@""] || [phoneNumber isEqualToString:@""]) {
>>>>>>> c177046d13e0f1d1de1fb921af174cc017a5c648
        //调用了Utilities公有方法弹出框
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
        return;
    }
    if (![password isEqualToString:confirmPwd]) {
            [Utilities popUpAlertViewWithMsg:@"俩次输入的密码不一致" andTitle:nil];
            return;
    }
<<<<<<< HEAD
       //写人数据库
=======
    if (!([phoneNumber length]==i)){
        [Utilities popUpAlertViewWithMsg:@"请填写正确的手机号码！" andTitle:nil];
        return;
    }
    //写人数据库
>>>>>>> c177046d13e0f1d1de1fb921af174cc017a5c648
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    user[@"Address"]=address;
    user[@"Phonenumber"] = phoneNumber;
    user[@"Money"] = @10000;
    
     UIImage *imag=[UIImage imageNamed:@"Image"];
    NSData *photoData = UIImagePNGRepresentation(imag);
    PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
    user[@"TouXiang"] = photoFile;
 
    //活动指示器
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiv.frame = self.view.bounds;
    [self.view addSubview:aiv];
    [aiv startAnimating];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
           // [Utilities setUserDefaults:@"userName" content:_username];
            [[storageMgr singletonStorageMgr] addKeyAndValue:@"signup" And:@1];
            
            [self.navigationController popViewControllerAnimated:YES];
        } else if (error.code == 202) {
            [Utilities popUpAlertViewWithMsg:@"该用户名已被使用，请尝试其它名称" andTitle:nil];
        }else if (error.code == 125) {
            [Utilities popUpAlertViewWithMsg:@"该电子邮箱地址为非法地址" andTitle:nil];
        }else if (error.code == 203) {
            [Utilities popUpAlertViewWithMsg:@"该电子邮箱已被使用，请尝试其它名称" andTitle:nil];
        } else if (error.code == 100) {
            [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil];
        } else{
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
            return;
        }
        
    }];
        
}

//
//- (IBAction)backAction:(UIBarButtonItem *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    return [self validateNumber:string];
//}



@end
