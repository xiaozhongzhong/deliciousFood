//
//  firstcellViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "firstcellViewController.h"

@interface firstcellViewController ()
- (IBAction)shopAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation firstcellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.label.text=self.item[@"Discriptiondetail"];

    self.name.text=self.item[@"Dishes"];
    self.pirce.text=[NSString stringWithFormat:@"价格：  %@元",_item[@"Price"]];
    PFFile *photo =self.item[@"Photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageview.image = image;
            });
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

- (IBAction)shopAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    
    
}

- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event {
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    PFObject *booking=[PFObject objectWithClassName:@"Favarites"];
    booking[@"Timer"]=strDate;
    
    PFUser *currentUser = [PFUser currentUser];
    booking[@"FavaritesUser"]=currentUser;
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [ booking saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (succeeded) {
            //回到上一页前更新页面的通知
            // [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"refreshMine" object:self] waitUntilDone:YES];
            //返回上一页
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];

}
@end
