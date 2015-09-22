//
//  LeftViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/22.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "LeftViewController.h"
#import "passwordViewController.h"
@interface LeftViewController ()
- (IBAction)usenameAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)passwordAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)adressAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)tuichiAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image=[UIImage imageNamed:@"5.png"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"2.png"]];
    [self readingUsername];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)readingUsername{
    //读取用户名
    PFUser *currentUser = [PFUser currentUser];
    self.username.text=[NSString stringWithFormat:@"账号信息：%@",currentUser[@"username"]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self readingUsername];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [self readingUsername];
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([textField.text isEqualToString:@""]||[textField.text isEqualToString:self.username.text]) {
            [Utilities popUpAlertViewWithMsg:@"你输入的用户名为空或重复" andTitle:nil]
            ;
            return;
        }
        PFUser *user=[PFUser currentUser];
        user[@"username"]=textField.text;
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [aiv stopAnimating];
            if (succeeded) {
                [Utilities setUserDefaults:@"userName" content:textField.text];
                [self readingUsername];
                
            } else {
                [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
            }
        }];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   }


- (IBAction)usenameAction:(UIButton *)sender forEvent:(UIEvent *)event {
    UIAlertView *sellView = [[UIAlertView alloc]initWithTitle:@"警告" message:[NSString stringWithFormat:@"修改的用户名是：%@\n请输入你修改后的用户名",self.username.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [sellView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [sellView show];

}

- (IBAction)passwordAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)adressAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
  }

- (IBAction)tuichiAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
