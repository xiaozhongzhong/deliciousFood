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
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = NSTextAlignmentLeft;
//    paragraphStyle.maximumLineHeight = 60;  //最大的行高
//    paragraphStyle.lineSpacing = 5;  //行自定义行高度
//    [paragraphStyle setFirstLineHeadIndent:self.label.frame.size.width + 5];//首行缩进 根据用户昵称宽度在加5个像素
    

//    self.numbers.text=[NSString stringWithFormat:@"1"];
//
//    index = 0;
//
//
//    // Do any additional setup after loading the view.
//
//    //NSLog(@"%@",_item);
//    index = 0;

    self.numbers.text=[NSString stringWithFormat:@"1"];

    
    //[_shoucangjia setTitle:@"加入收藏夹" forState:UIControlStateNormal];

    self.label.text=self.item[@"Discriptiondetail"];

    self.name.text=[NSString stringWithFormat:@"菜名：  %@",self.item[@"Dishes"]];
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
                //PFObject *object=[PFObject object];
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
    shoping[@"Name"]=self.name.text;
    NSNumberFormatter *numberFortnatters=[[NSNumberFormatter alloc]init];
    [numberFortnatters setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber  *bentop= [numberFortnatters numberFromString:self.numbers.text];
        shoping[@"TotalPrice"]=_item[@"Price"];
    shoping[@"Bento"]=bentop;
    PFFile *photo =self.item[@"Photo"];
        shoping[@"Photo"] =photo;
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
<<<<<<< HEAD
        [_booking deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [_shoucangjia setTitle:@"加入收藏夹" forState:UIControlStateNormal];
=======
    [_booking deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
>>>>>>> 93b89a35f253466083e0288ef1d16257cb617533
                [Utilities popUpAlertViewWithMsg:@"您已取消收藏" andTitle:nil];
                 [_shoucangjia setTitle:@"加入收藏夹" forState:UIControlStateNormal];
                index = 0;
            }
        }];
    }
    
}

- (IBAction)addAction:(UIStepper *)sender forEvent:(UIEvent *)event {
    
    
    self.add.minimumValue=1;
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
