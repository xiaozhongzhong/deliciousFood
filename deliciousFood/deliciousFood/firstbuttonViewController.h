//
//  firstbuttonViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstbuttonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)NSArray *objectsForShow;
@property (strong, nonatomic)PFObject *item;


@end
