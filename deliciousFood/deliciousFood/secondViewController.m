//
//  secondViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "secondViewController.h"
#import "firstcellViewController.h"
#import "shopTableViewCell.h"
#import "shopmoneyViewController.h"


@interface secondViewController ()

- (IBAction)jiesuanAction:(UIBarButtonItem *)sender;

- (IBAction)editAction:(UIBarButtonItem *)sender;


@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self query];
//        [self.tableview setEditing:NO];
//    [self.edit setTitle:@"选择"];
//    if ([[self.edit title] isEqual:@"选择"]) {
//        [self.tableview setEditing:NO];
//    }else if([[self.edit title] isEqual:@"取消"])
//    {
//        [self.tableview setEditing:YES];
//    }
   }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Cell"]) {
        //获得当前tableview行选中的数据
        PFObject *object = [_objectForShow objectAtIndex:[self.tableview indexPathForSelectedRow].row];
        shopmoneyViewController *shopMoneyVC = segue.destinationViewController;
        shopMoneyVC.Item = object;
        shopMoneyVC.hidesBottomBarWhenPushed = YES;
    } else if ([segue.identifier isEqualToString:@"jiesuan"]) {
        CGFloat sum = 0;
        NSArray *indexPaths = [_tableview indexPathsForSelectedRows];
        for (NSIndexPath *indexPath in indexPaths) {
            PFObject *object = [_objectForShow objectAtIndex:indexPath.row];
            NSNumber *priceNum = object[@"TotalPrice"];
            sum += [priceNum floatValue];
            object[@"TotalPrice"]=[NSString stringWithFormat:@"%.2f",sum];
            shopmoneyViewController *shopMoneyVC = segue.destinationViewController;
            shopMoneyVC.Item = object[@"TotalPrice"];
            shopMoneyVC.hidesBottomBarWhenPushed = YES;
        }
       
        [_tableview setEditing:NO];
         [self.edit setTitle:@"选择"];
        
    }


}

-(void)query
{
    PFQuery *query=[PFQuery queryWithClassName:@"Shoppingcart"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array,NSError *error){
        if (!error) {
            self.objectForShow = array;
            [self.tableview reloadData];
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _objectForShow.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    shopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object=[self.objectForShow objectAtIndex:indexPath.row];
    cell.name.text=object[@"Name"];
    cell.price.text=[NSString stringWithFormat:@"%@元",object[@"TotalPrice"]];
   cell.number.text=[NSString stringWithFormat:@"%@份盒饭",object[@"Bento"]];
    PFFile *photo =object[@"Photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageview.image = image;
                            });
        }
    }];
        return cell;
 
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
      NSLog(@"%ld", (long)indexPath.row);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *object=[self.objectForShow objectAtIndex:indexPath.row];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
           if (succeeded) {
               [Utilities popUpAlertViewWithMsg:@"成功删除" andTitle:nil];
               [self.objectForShow removeObjectAtIndex:indexPath.row];
               [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
           }
        }];
   
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        
        
        
          }
}


- (IBAction)jiesuanAction:(UIBarButtonItem *)sender {
    CGFloat sum = 0;
    NSArray *indexPaths = [_tableview indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in indexPaths) {
        PFObject *object = [_objectForShow objectAtIndex:indexPath.row];
        NSNumber *priceNum = object[@"TotalPrice"];
        sum += [priceNum floatValue];
    }
    NSLog(@"%f", sum);
}

- (IBAction)editAction:(UIBarButtonItem *)sender {
     [self.tableview setEditing:NO];
    if (self.edit.enabled==YES) {
        [self.edit setTitle:@"取消"];
        [self.tableview setEditing:YES];
        
        
    }
    if(self.edit.enabled==NO ){
        
        [self.tableview setEditing:NO];
        [self.edit setTitle:@"选择"];
           }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    //回到当前页面,取消刚刚的选项
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
