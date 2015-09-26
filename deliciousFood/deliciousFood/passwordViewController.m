//
//  passwordViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/22.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "passwordViewController.h"

@interface passwordViewController ()
- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)doneAction:(UIBarButtonItem *)sender;

@end

@implementation passwordViewController

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

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneAction:(UIBarButtonItem *)sender {
    if (![self.oldpasswordTF.text isEqualToString:@""] || ![self.newpasswordTF.text isEqualToString:@""] || ![self.newnewpassword.text isEqualToString:@""]){
      
    if ([self.oldpasswordTF.text isEqualToString:[Utilities getUserDefaults:@"passWord"]]) {
        
        if ([self.newpasswordTF.text isEqualToString:self.newnewpassword.text]) {
            PFUser *currUser=[PFUser currentUser];
            currUser.password=self.newpasswordTF.text;
            UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
            [currUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [aiv stopAnimating];
                if (succeeded) {
                    [Utilities setUserDefaults:@"passWord" content:self.newpasswordTF.text];
                    [Utilities popUpAlertViewWithMsg:@"成功修改！" andTitle:nil];
                    
                    [PFUser logOut];//退出Parse
                    [aiv startAnimating];
                    //重新登录
                    [PFUser logInWithUsernameInBackground:currUser.username password:self.newpasswordTF.text block:^(PFUser *user, NSError *error) {
                        
                        [aiv stopAnimating];
                        if (user) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                        } else if (error.code == 101) {
                            [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil];
                        } else if (error.code == 100) {
                            [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil];
                        }else{
                            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                        }
                    }];
                    
                    
                    //[self.navigationController popViewControllerAnimated:YES];
                } else {
                    [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                }
            }];
        }else{
            [Utilities popUpAlertViewWithMsg:@"俩次密码不一致，请重新输入" andTitle:nil];
        }
        
    }else{
        [Utilities popUpAlertViewWithMsg:@"与原密码不同，请重新输入" andTitle:nil];
    }
    }else{
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
    }
}


@end
