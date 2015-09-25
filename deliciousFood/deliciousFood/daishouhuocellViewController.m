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
    NSLog(@"%@",_item);
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
            NSString *first;
            for (int i; i<[array count]; i++) {
                 PFObject *object = [array objectAtIndex:i];
                //NSLog(@"%@",object);
                first = object[@"Dishes"];
                NSLog(@"first = %@",first);
            }
            
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
