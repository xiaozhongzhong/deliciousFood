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
    
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    NSString *total = [numberFormatter stringFromNumber:_item[@"totalPrice"]];
    _totalPrice.text =[NSString stringWithFormat:@"%@元" ,total];
    PFRelation *relation = [_item relationForKey:@"BookingVeg"];
    PFUser *currentUser = [PFUser currentUser];
    PFFile *photo =currentUser[@"TouXiang"];
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [aiv startAnimating];
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
            [aiv stopAnimating];
            _username.text = currentUser[@"username"];
            PFObject *object;
            NSMutableArray *mutable = [NSMutableArray new];
            for (object in array) {
            [mutable addObject:object[@"Dishes"]];
                         }
            NSString *string = [mutable componentsJoinedByString:@","];
            self.foodname.text=[NSString stringWithFormat:@"%@",string];
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
    
    PFObject *object = [PFObject objectWithClassName:@"Dingdan"];
    object[@"Name"] = _foodname.text;
        object[@"totalPrice"] = _item[@"totalPrice"];
    PFUser *currentUser = [PFUser currentUser];
    object[@"DingdanUser"] = currentUser;
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [aiv startAnimating];
    [object saveInBackgroundWithBlock:^(BOOL successed,NSError *error){
        if (successed) {
                [_item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                 [aiv stopAnimating];
                    [Utilities popUpAlertViewWithMsg:@"已确认成功！" andTitle:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];

        }
    }];
 
}
@end
