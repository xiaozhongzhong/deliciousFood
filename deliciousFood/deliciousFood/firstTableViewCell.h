//
//  firstTableViewCell.h
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVI;
@property (weak, nonatomic) IBOutlet UILabel *foodname;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *unlike;
@property (weak, nonatomic) IBOutlet UILabel *foodDetail;

@end
