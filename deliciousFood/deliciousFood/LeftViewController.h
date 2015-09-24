//
//  LeftViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/22.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *xiugaiusername;
@property (weak, nonatomic) IBOutlet UIButton *xiugaipassword;
@property (weak, nonatomic) IBOutlet UIButton *xiugaiaddress;
- (IBAction)pickAction:(UITapGestureRecognizer *)sender;

@end
