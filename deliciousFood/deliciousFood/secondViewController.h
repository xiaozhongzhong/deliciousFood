//
//  secondViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)NSMutableArray *objectForShow;
@property(strong,nonatomic)NSMutableDictionary *deleDic;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button;
@property(strong,nonatomic) PFObject *item;

@end
