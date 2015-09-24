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
    self.zongjinumber.text=[NSString stringWithFormat:@"%@元",self.Item[@"TotalPrice"]];

    
    
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
    PFUser *user=[PFUser currentUser];
    NSNumber *money=user[@"Money"];
    int money1=[money intValue];
    int number=[self.zongjinumber.text intValue];
    
    int yuer;
       if (money1>number) {
       yuer=money1-number;
          NSLog(@"%d",yuer);
         }
    NSNumber *money2=[NSNumber numberWithInt:yuer];
    PFUser *user123 = [PFUser currentUser];
    user123[@"Money"]=money2;
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [user123 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (succeeded) {
            [Utilities popUpAlertViewWithMsg:@"减款成功，谢谢再次惠顾！" andTitle:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
    
    PFObject *objectBooking=[PFObject objectWithClassName:@"Booking"];
    objectBooking[@"BookingUser"]=user;
    objectBooking[@"BookingShop"]=self.Item;
 UIActivityIndicatorView *aiv1 = [Utilities getCoverOnView:self.view];    [objectBooking saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv1 stopAnimating];
        if (succeeded) {
            [Utilities popUpAlertViewWithMsg:@"已加入代收货" andTitle:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
    
    
}
@end
