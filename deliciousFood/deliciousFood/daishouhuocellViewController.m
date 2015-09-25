//
//  daishouhuocellViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/24.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "daishouhuocellViewController.h"

@interface daishouhuocellViewController ()
- (IBAction)queryAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation daishouhuocellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    NSString *total = [numberFormatter stringFromNumber:_item[@"totalPrice"]];
    _totalPrice.text = total;


    // Do any additional setup after loading the view.
//    PFObject *object = [PFObject objectWithClassName:@"Booking"];
    PFRelation *relation = [_item relationForKey:@"BookingVeg"];
    PFUser *currentUser = [PFUser currentUser];
    PFFile *photo =currentUser[@"TouXiang"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageVi.image = image;
            });
        }
    }];
    [[relation query]findObjectsInBackgroundWithBlock:^(NSArray *array,NSError *error){
        if (!error) {
            _username.text = currentUser[@"username"];
            //NSLog(@"%@",array);
            
                     // for (int i=0; i<[array count]; i++) {
//                if (i) {
//                object = [array objectAtIndex:i-1];
//                    NSLog(@"%@",object);
//                str = object[@"Dishes"];
//                    _foodname.text = [NSString stringWithFormat:@"%@%@%@",str,str,str];
//               
//                    continue;
//                }
//                NSLog(@"111 = %@",str);
            PFObject *object=[array objectAtIndex:0];
            NSString *str=[NSString stringWithFormat:@"1.%@  ", object[@"Dishes"]];
            PFObject *object1=[array objectAtIndex:1];
            NSString *str1=[NSString stringWithFormat:@"2.%@  ", object1[@"Dishes"]];
            PFObject *object2=[array objectAtIndex:2];
            NSString *str2=[NSString stringWithFormat:@"3.%@  ",object2[@"Dishes"]];
            NSString *str12=[str stringByAppendingString:str1];
            NSString *str123=[str12 stringByAppendingString:str2];
            self.foodname.text=str123;
            
        }else{
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];

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

- (IBAction)queryAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
}
@end
