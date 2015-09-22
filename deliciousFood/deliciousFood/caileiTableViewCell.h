//
//  caileiTableViewCell.h
//  deliciousFood
//
//  Created by admin1 on 15/9/22.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface caileiTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *foodname;
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *Umlike;
@property (weak, nonatomic) IBOutlet UILabel *jieshao;
@end
