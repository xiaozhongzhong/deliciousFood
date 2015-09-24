//
//  shopmoneyViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "shopmoneyViewController.h"
#import "secondViewController.h"
@interface shopmoneyViewController ()
- (IBAction)querenAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation shopmoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *user=[PFUser currentUser];
    self.shouhuorenTF.text=user[@"username"];
    self.phoneTF.text=user[@"Phonenumber"];
    self.addressTF.text=user[@"Address"];
  //  NSLog(@"%@",self.Item);
    self.zongjinumber.text=[NSString stringWithFormat:@"%@元",self.Item];
//    PFObject *object=[PFObject object];
//    self.zongjinumber.text=[NSString stringWithFormat:@"%@元",object[@"sum"]];
    
    
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

- (IBAction)querenAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
