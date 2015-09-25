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
    self.zongjinumber.text=[NSString stringWithFormat:@"%@元",self.totalPrice];
    
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
         }
    NSNumber *money2=[NSNumber numberWithInt:yuer];
    
    PFObject *objectBooking=[PFObject objectWithClassName:@"Booking"];
    objectBooking[@"BookingUser"]=user;
    objectBooking[@"totalPrice"]=_totalPrice;
    PFRelation *relation = [objectBooking relationForKey:@"BookingVeg"];
    for (PFObject *vege in _vegeArr) {
        [relation addObject:vege];
        }
    
    UIActivityIndicatorView *aiv1 = [Utilities getCoverOnView:self.view];
    [objectBooking saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv1 stopAnimating];
        if (succeeded) {
            PFUser *user123 = [PFUser currentUser];
            user123[@"Money"]=money2;
            UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
            [user123 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    [self removeOBject];
                    [aiv stopAnimating];
                    [[storageMgr singletonStorageMgr] addKeyAndValue:@"delect" And:@1];
                    [Utilities popUpAlertViewWithMsg:@"下单成功，谢谢再次惠顾！" andTitle:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } else {
                    [aiv stopAnimating];
                    [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                }
            }];
            
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
//    
//    [self.Item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//        
//    }];
}

-(void)removeOBject{
    for (int i = 0; i < _objectArr.count; i ++) {
        PFObject *object = [_objectArr objectAtIndex:i];
        NSLog(@"%@",object);
        [object delete];
    }
}

@end
