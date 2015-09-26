//
//  firstcellViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "firstcellViewController.h"
#import "secondViewController.h"
@interface firstcellViewController ()
- (IBAction)shopAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)addAction:(UIStepper *)sender forEvent:(UIEvent *)event;

@end

@implementation firstcellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;
      self.add.minimumValue=1;
    
    self.numbers.text=[NSString stringWithFormat:@"1"];
    self.label.text=[NSString stringWithFormat:@"简介：\n     %@" ,self.item[@"Discriptiondetail"]];
    self.name.text=[NSString stringWithFormat:@"菜名：  %@",self.item[@"Dishes"]];
    self.pirce.text=[NSString stringWithFormat:@"价格：  %@元/份",_item[@"Price"]];
    PFFile *photo =self.item[@"Photo"];
     UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [aiv startAnimating];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            [aiv stopAnimating];
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageview.image = image;
            });
        }
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    PFQuery *query = [PFQuery queryWithClassName:@"Favarites"];
    [query whereKey:@"FavVegs" equalTo:_item];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error){
        if (!error) {
            if (number == 0) {
                [_shoucangjia setTitle:@"加入收藏夹" forState:UIControlStateNormal];
                index = 0;
            } else {
                [_shoucangjia setTitle:@"已收藏" forState:UIControlStateNormal];
                index = 1;
                
            }
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shopAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    PFObject *shoping=[PFObject objectWithClassName:@"Shoppingcart"];
    PFUser *currentUser = [PFUser currentUser];
    shoping[@"ShopUser"]=currentUser;
    shoping[@"timer"]=strDate;
    shoping[@"ShopVeg"]=self.item;
    NSNumberFormatter *numberFortnatters=[[NSNumberFormatter alloc]init];
    [numberFortnatters setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber  *bentop= [numberFortnatters numberFromString:self.numbers.text];
       // shoping[@"TotalPrice"]=_item[@"Price"];
    shoping[@"Bento"]=bentop;
    //PFFile *photo =self.item[@"Photo"];
       // shoping[@"Photo"] =photo;
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [shoping saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (succeeded) {
            //回到上一页前更新页面的通知
            // [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"refreshMine" object:self] waitUntilDone:YES];
            //返回上一页
            [Utilities popUpAlertViewWithMsg:@"加入购物车成功！" andTitle:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
    
    
}

- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if (index == 0){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        _booking=[PFObject objectWithClassName:@"Favarites"];
        
        _booking[@"Timer"]=strDate;
        _booking[@"Name"]=self.name.text;
    
        PFFile *photo =self.item[@"Photo"];
        _booking[@"Photo"] =photo;
        
        //关联用户和食物
        PFUser *currentUser = [PFUser currentUser];
        _booking[@"FavaritesUser"]=currentUser;
        _booking[@"FavVegs"]=_item;
        
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [ _booking saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
            if (succeeded) {
            //回到上一页前更新页面的通知
            // [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"refreshMine" object:self] waitUntilDone:YES];
            //返回上一页
               [Utilities popUpAlertViewWithMsg:@"收藏成功！" andTitle:nil];
               index = 1;
               [_shoucangjia setTitle:@"已收藏" forState:UIControlStateNormal];
              //[self.navigationController popViewControllerAnimated:YES];
            } else {
                [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
            }
        }];
    }else{

        PFQuery *query = [PFQuery queryWithClassName:@"Favarites"];
        [query whereKey:@"FavVegs" equalTo:_item];
     
        [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
            
            for (PFObject *comment in comments) {
                
                [comment deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [_shoucangjia setTitle:@"加入收藏夹" forState:UIControlStateNormal];
                        [Utilities popUpAlertViewWithMsg:@"您已取消收藏" andTitle:nil];
                        index = 0;
                    }
                }];

            }
        }];
    }
}

- (IBAction)addAction:(UIStepper *)sender forEvent:(UIEvent *)event {
    
    
  
    self.add.maximumValue=5;
    [self.add setStepValue:1.0];
    [self.add setWraps:NO];
    [self.add addTarget:self action:@selector(stepper:) forControlEvents:UIControlEventValueChanged];

    self.numbers.text=[NSString stringWithFormat:@"%.0lf",self.add.value];
    
    
    
}
///事件 控制值
- (void)stepper:(UIStepper*)stepper{
    self.numbers.text = [NSString stringWithFormat:@"%.0lf",self.add.value];
}

@end
