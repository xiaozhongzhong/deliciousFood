//
//  daishouhuoViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "daishouhuoViewController.h"
#import "daishouhuoTableViewCell.h"
#import "daishouhuocellViewController.h"
@interface daishouhuoViewController ()

@end

@implementation daishouhuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _tableview.tableFooterView = [[UIView alloc] init];
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;
    [self query];
    [self uiConfiguration];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        [self query];
    }
-(void)query{
    PFUser *currentUser = [PFUser currentUser];
    //查询当前表中所有owner字段当前用户的信息
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"BookingUser == %@", currentUser];
    PFQuery *query=[PFQuery queryWithClassName:@"Booking" predicate:predicate];
    [query includeKey:@"BookingUser"];
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectArray = [[NSMutableArray alloc] initWithArray:returnedObjects];
            [self.tableview reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"daishouhuo"]) {
        //获得当前tableview行选中的数据
        PFObject *object = [_objectArray objectAtIndex:[_tableview indexPathForSelectedRow].row];
        daishouhuocellViewController *firstcellVC = segue.destinationViewController;
        firstcellVC.item = object;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objectArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    daishouhuoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object=[self.objectArray objectAtIndex:indexPath.row];
    PFUser *user = object[@"BookingUser"];
    PFFile *photo =user[@"TouXiang"];
      [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageview.image = image;
            });
        }
    }];
      cell.pirce.text=[NSString stringWithFormat:@"%@元",object[@"totalPrice"]];
    cell.name.text=user.username;

     cell.times.text=[NSString stringWithFormat:@"送货时间：%@",object[@"eatDate"]];
        return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
       return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *object=[_objectArray objectAtIndex:indexPath.row];
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];

        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
             [aiv stopAnimating];
            if (succeeded) {
                [Utilities popUpAlertViewWithMsg:@"成功删除" andTitle:nil];
                [self.objectArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}
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
