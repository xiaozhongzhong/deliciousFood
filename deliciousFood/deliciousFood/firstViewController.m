//
//  firstViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "firstViewController.h"
#import "firstTableViewCell.h"
#import "firstcellViewController.h"


@interface firstViewController ()
- (IBAction)zaodian:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)caociaAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)tangAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)yeAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestData {
    PFQuery *query = [PFQuery queryWithClassName:@"Vegetables"];
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectsForShow = returnedObjects;
           
            [_TabV reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([segue.identifier isEqualToString:@"Cell"]) {
        //获得当前tableview行选中的数据
        PFObject *object = [_objectsForShow objectAtIndex:[_TabV indexPathForSelectedRow].row];
        firstcellViewController *firstcellVC = segue.destinationViewController;
        firstcellVC.item = object;
        firstcellVC.hidesBottomBarWhenPushed = YES;
    }

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objectsForShow.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    firstTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object=[self.objectsForShow objectAtIndex:indexPath.row
                      ];
    cell.foodname.text=object[@"Dishes"];
    cell.price.text=[NSString stringWithFormat:@"%@元",object[@"Price"]];
    cell.like.text=[NSString stringWithFormat:@"%@",object[@"Like"]];
    cell.unlike.text=[NSString stringWithFormat:@"%@",object[@"Unlike"]];
    cell.foodDetail.text=object[@"Discriptiondetail"];
    PFFile *photo =object[@"Photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageVI.image = image;
            });
        }
    }];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //回到当前页面,取消刚刚的选项
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (IBAction)zaodian:(UIButton *)sender forEvent:(UIEvent *)event {
       [self performSegueWithIdentifier:@"first" sender:self];
}

- (IBAction)caociaAction:(UIButton *)sender forEvent:(UIEvent *)event {
   
}

- (IBAction)tangAction:(UIButton *)sender forEvent:(UIEvent *)event {
   
}

- (IBAction)yeAction:(UIButton *)sender forEvent:(UIEvent *)event {
   }
@end
