//
//  dingdanViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "dingdanViewController.h"
#import "dingdanTableViewCell.h"

@interface dingdanViewController ()

@end

@implementation dingdanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //清除多余的下划线
    _tableview.tableFooterView = [[UIView alloc] init];
    
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
 

    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self query];
    [self uiConfiguration];

}
-(void)query{
    PFQuery *query = [PFQuery queryWithClassName:@"Dingdan"];
    [query includeKey:@"DingdanUser"];
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [aiv startAnimating];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error){
        [aiv stopAnimating];
        if (!error) {
            //_objectsForShow = returnedObjects;
            self.objectsForShow =[[NSMutableArray alloc] initWithArray:returnedObjects];
            
            [_tableview reloadData];
        } else {
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_objectsForShow count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    dingdanTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object=[self.objectsForShow objectAtIndex:indexPath.row
                      ];
    cell.name.text=object[@"Name"];
    cell.price.text=[NSString stringWithFormat:@"%@元",object[@"totalPrice"]];
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *locationString=[dateformatter stringFromDate:currentdate];
    cell.times.text=[NSString stringWithFormat:@"%@",locationString];
    PFUser *currentUser = [PFUser currentUser];
    PFFile *photo =currentUser[@"TouXiang"];
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


//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        PFObject *object=[self.objectsForShow objectAtIndex:indexPath.row];
//        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
//        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            [aiv stopAnimating];
//            if (succeeded) {
//                [Utilities popUpAlertViewWithMsg:@"成功删除" andTitle:nil];
//                [self.objectsForShow removeObjectAtIndex:indexPath.row];
//                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            }
//        }];
//        
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //回到当前页面,取消刚刚的选项
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)uiConfiguration
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSString *title = [NSString stringWithFormat:@"下拉即可刷新"];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attrsDictionary = @{NSUnderlineStyleAttributeName:
                                          @(NSUnderlineStyleNone),
                                      NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                      NSParagraphStyleAttributeName:style,
                                      NSForegroundColorAttributeName:[UIColor brownColor]};
    
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
    //tintColor旋转的小花的颜色
    refreshControl.tintColor = [UIColor brownColor];
    //背景色 浅灰色
    refreshControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //执行的动作
    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [_tableview addSubview:refreshControl];
    
}
- (void)refreshData:(UIRefreshControl *)rc
{
    [self query];
    [_tableview reloadData];
    //怎么样让方法延迟执行的
    [self performSelector:@selector(endRefreshing:) withObject:rc];//afterDelay:1.f];
}
- (void)endRefreshing:(UIRefreshControl *)rc {
    // [self query];
    //[_tableView reloadData];
    [rc endRefreshing];//闭合
}


@end
