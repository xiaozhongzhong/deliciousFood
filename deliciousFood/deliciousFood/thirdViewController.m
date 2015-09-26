//
//  thirdViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "thirdViewController.h"

@interface thirdViewController ()
- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)daifahuoAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)dingdanAction:(UIButton *)sender forEvent:(UIEvent *)event;



@end

@implementation thirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;
    //读取用户名
    PFUser *currentUser = [PFUser currentUser];
     NSNumberFormatter *numberFortnatters=[[NSNumberFormatter alloc]init];
    self.username.text=[NSString stringWithFormat:@"%@",currentUser[@"username"]];
    NSString *numbers=[numberFortnatters stringFromNumber:currentUser[@"Money"]];
    self.toprice.text=[NSString stringWithFormat:@"%@元",numbers];
    PFFile *photo =currentUser[@"TouXiang"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageview.image = image;
            });
        }
    }];

    // Do any additional setup after loading the view.
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

- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)daifahuoAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)dingdanAction:(UIButton *)sender forEvent:(UIEvent *)event {
}





@end
