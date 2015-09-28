//
//  shopmoneyViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopmoneyViewController : UIViewController<UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *shouhuorenTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *zongjinumber;
@property (strong,nonatomic) NSNumber *totalPrice;
@property (strong, nonatomic) NSMutableArray *vegeArr;
@property(strong,nonatomic) NSMutableArray *objectArr;
@property(strong,nonatomic)NSString *string;
@end
