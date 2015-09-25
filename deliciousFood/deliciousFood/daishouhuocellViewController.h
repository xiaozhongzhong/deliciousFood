//
//  daishouhuocellViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/24.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface daishouhuocellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *foodname;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
//@property (strong, nonatomic) NSMutableArray *objectArray;
//@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) PFObject *item;

@end
