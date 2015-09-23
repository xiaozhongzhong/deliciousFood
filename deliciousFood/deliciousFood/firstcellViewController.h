//
//  firstcellViewController.h
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstcellViewController : UIViewController{
    //收藏夹Title文本的修改
    BOOL index ;
    int count;
}

@property (strong,nonatomic) PFObject *item;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *pirce;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *shopcar;
@property (weak, nonatomic) IBOutlet UIButton *shoucangjia;
@property (weak, nonatomic) IBOutlet UILabel *numbers;
@property (weak, nonatomic) IBOutlet UIStepper *add;
@property (strong, nonatomic) PFObject *booking;
@property(strong,nonatomic)NSArray *storArray;
@end
