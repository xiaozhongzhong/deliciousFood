//
//  loginViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
@interface loginViewController : UIViewController<UIViewControllerAnimatedTransitioning, ECSlidingViewControllerDelegate, ECSlidingViewControllerLayout, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property(strong,nonatomic)ECSlidingViewController *slidingViewController;
@property(assign,nonatomic)ECSlidingViewControllerOperation operation;
@property (strong, nonatomic) NSString *unInput;
@end
