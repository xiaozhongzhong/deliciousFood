//
//  shopmoneyViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopmoneyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *shouhuorenTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *zongjinumber;
@property (strong, nonatomic)NSArray *objectForShow;
@property(strong,nonatomic)PFObject *Item;
@end
