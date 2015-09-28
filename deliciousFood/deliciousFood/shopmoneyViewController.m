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
    _dateDay.text = [NSString stringWithFormat:@"送货时间"];
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;
    PFUser *user=[PFUser currentUser];
    self.shouhuorenTF.text=user[@"username"];
    self.phoneTF.text=user[@"Phonenumber"];
    self.addressTF.text=user[@"Address"];
    self.zongjinumber.text=[NSString stringWithFormat:@"%@元",self.totalPrice];
    self.datePicker.minimumDate=[NSDate date];
    NSDate *dateMax=[NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    self.datePicker.maximumDate=dateMax;

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
-(void)public{
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
    NSDate *select  = [_datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    
    objectBooking[@"eatDate"] =dateAndTime;
    PFRelation *relation = [objectBooking relationForKey:@"BookingVeg"];
    PFObject *vege;
    for (vege in _vegeArr) {
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
                    [Utilities popUpAlertViewWithMsg:@"订餐成功，我们将尽快派送，谢谢！再次惠顾！" andTitle:nil];
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
}


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
    
        NSDate *select  = [_datePicker date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    objectBooking[@"eatDate"] =dateAndTime;
    
    
    NSDate *datepice=[dateFormatter dateFromString:dateAndTime];
    NSDate *date1=[dateFormatter dateFromString:@"08:00"];
     NSTimeInterval timeBetween=[datepice timeIntervalSinceDate:date1];
    NSDate *date2=[dateFormatter dateFromString:@"23:00"];
    NSTimeInterval timeBetween1=[datepice timeIntervalSinceDate:date2];
    PFRelation *relation = [objectBooking relationForKey:@"BookingVeg"];
    PFObject *vege;
     NSMutableArray *mutable = [NSMutableArray new];
    
    for (vege in _vegeArr) {
        [relation addObject:vege];
        [mutable addObject:vege[@"Type"]];
          //创建了两个日期对象
    //    if ([vege[@"Type"]isEqualToString:@"早点"]&&[vege[@"Type"]isEqualToString:@"夜宵"]) {
//            [Utilities popUpAlertViewWithMsg:@"早点夜宵不能同时预定" andTitle:nil];
//        }
        NSLog(@"%@",mutable);
    if ([vege[@"Type"] isEqualToString:@"早点"]&&timeBetween>0) {
        [Utilities popUpAlertViewWithMsg:@"你订的早点过了我们的订餐时间，请 在每天8点之前预定" andTitle:nil];
        return;
        
    }
    if ([vege[@"Type"] isEqualToString:@"夜宵"]&&timeBetween1>0){
        [Utilities popUpAlertViewWithMsg:@"你定的夜宵过了我们的订餐时间,请在每天23点之前预定" andTitle:nil];
        return;
    
        }
    }
    
    

    self.string=[mutable componentsJoinedByString:@","];
    //NSLog(@"aaa=%@",self.string);
    int i=0;
    int j =0;
    for (NSString *mu in mutable){
        if ([mu isEqualToString:@"早点"]) {
            i ++;
        }
        if ([mu isEqualToString:@"夜宵"]) {
            j++;
        }
    }
    if (i >= 1 && j >=1) {
        [Utilities popUpAlertViewWithMsg:@"早点和夜宵不能同时预定" andTitle:nil];
        return;
    }
    
    for (NSString *mu in mutable){
        if ([mu isEqualToString:@"早点"]) {
            i ++;
        }
        if ([mu isEqualToString:@"汤"]) {
            j++;
        }
    }
    if (i >= 1 && j >=1) {
        [Utilities popUpAlertViewWithMsg:@"早点和汤不能同时预定" andTitle:nil];
        return;
    }
    
    for (NSString *mu in mutable){
        if ([mu isEqualToString:@"早点"]) {
            i ++;
        }
        if ([mu isEqualToString:@"炒菜"]) {
            j++;
        }
    }
    if (i >= 1 && j >=1) {
        [Utilities popUpAlertViewWithMsg:@"早点和炒菜不能同时预定" andTitle:nil];
        return;
    }
    
    for (NSString *mu in mutable){
        if ([mu isEqualToString:@"汤"]) {
            i ++;
        }
        if ([mu isEqualToString:@"夜宵"]) {
            j++;
        }
    }
    if (i >= 1 && j >=1) {
        [Utilities popUpAlertViewWithMsg:@"汤和夜宵不能同时预定" andTitle:nil];
        return;
    }
    
    for (NSString *mu in mutable){
        if ([mu isEqualToString:@"炒菜"]) {
            i ++;
        }
        if ([mu isEqualToString:@"夜宵"]) {
            j++;
        }
    }
    if (i >= 1 && j >=1) {
        [Utilities popUpAlertViewWithMsg:@"炒菜和夜宵不能同时预定" andTitle:nil];
        return;
    }
    
    [self public];
 }



-(void)removeOBject{
    for (int i = 0; i < _objectArr.count; i ++) {
        PFObject *object = [_objectArr objectAtIndex:i];
        NSLog(@"%@",object);
        [object delete];
    }
}




@end
