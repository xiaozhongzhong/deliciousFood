//
//  firstcellViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "firstcellViewController.h"

@interface firstcellViewController ()
- (IBAction)shopAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)addAction:(UIStepper *)sender forEvent:(UIEvent *)event;

@end

@implementation firstcellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@",_item);
    index = 0;
    self.label.text=self.item[@"Discriptiondetail"];

    self.name.text=self.item[@"Dishes"];
    self.pirce.text=[NSString stringWithFormat:@"价格：  %@元",_item[@"Price"]];
    PFFile *photo =self.item[@"Photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageview.image = image;
            });
        }
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
//    NSLog(@"%@",query);
//    PFObject *object;
//    NSLog(@"%@",object[@"Name"]);
//    //[query whereKey:@"objectId" containedIn:_item[@"objectId"]];
//    NSString *str = object[@"objectId"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Favarites"];
    [query whereKey:@"FavVegs" equalTo:_item[@"Dishes"]];
    PFObject *object;
    NSString *str = object[@"Dishes"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
//        if (!error) {
//            [_shoucangjia setTitle:@"已收藏" forState:UIControlStateNormal];
//        } else {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
//    if(){
//        [_shoucangjia setTitle:@"已收藏" forState:UIControlStateNormal];
//    }else{
//        [_shoucangjia setTitle:@"加入收藏夹" forState:UIControlStateNormal];
//    }
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
        [_booking deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [_shoucangjia setTitle:@"加入收藏夹" forState:UIControlStateNormal];
                index = 0;
                [Utilities popUpAlertViewWithMsg:@"您已取消收藏" andTitle:nil];
            }
        }];
    }

}

- (IBAction)addAction:(UIStepper *)sender forEvent:(UIEvent *)event {
}
@end
