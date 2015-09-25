//
//  daishouhuocellTableViewCell.h
//  deliciousFood
//
//  Created by admin1 on 15/9/24.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface daishouhuocellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageviw;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *timers;

@end
