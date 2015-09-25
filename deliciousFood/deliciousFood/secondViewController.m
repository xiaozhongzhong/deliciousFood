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
    [self uiConfiguration];
   }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CGFloat sum = 0;
    NSMutableArray *vegeArr = [NSMutableArray new];
    shopmoneyViewController *shopMoneyVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"Cell"]) {
        //获得当前tableview行选中的数据
        PFObject *object = [_objectForShow objectAtIndex:[self.tableview indexPathForSelectedRow].row];
        PFObject *shopVeg=object[@"ShopVeg"];
        NSNumber *priceNum =shopVeg[@"Price"];
        sum += [priceNum floatValue];
        NSNumber *numTemp = [NSNumber numberWithFloat:sum];
        [vegeArr addObject:shopVeg];
        shopMoneyVC.totalPrice = numTemp;
        shopMoneyVC.vegeArr = vegeArr;
    } else if ([segue.identifier isEqualToString:@"jiesuan"]) {
        NSArray *indexPaths = [_tableview indexPathsForSelectedRows];
        for (NSIndexPath *indexPath in indexPaths) {
            PFObject *object = [_objectForShow objectAtIndex:indexPath.row];
            shopMoneyVC.objectmoney=object;
            PFObject *shopVeg=object[@"ShopVeg"];
            NSNumber *priceNum =shopVeg[@"Price"];
            sum += [priceNum floatValue];
            [vegeArr addObject:shopVeg];
        }
        NSNumber *numTemp = [NSNumber numberWithFloat:sum];
        shopMoneyVC.totalPrice = numTemp;
        shopMoneyVC.vegeArr = vegeArr;
       
        
        [_tableview setEditing:NO];
        [self.edit setTitle:@"选择"];
    }


}

-(void)query
{
    PFQuery *query=[PFQuery queryWithClassName:@"Shoppingcart"];
    [query includeKey:@"ShopUser"];
    [query includeKey:@"ShopVeg"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array,NSError *error){
        if (!error) {
            self.objectForShow =[[NSMutableArray alloc] initWithArray: array];
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
    PFObject *shopveg=object[@"ShopVeg"];
    cell.name.text=shopveg[@"Dishes"];
    cell.price.text=[NSString stringWithFormat:@"%@元",shopveg[@"Price"]];
   cell.number.text=[NSString stringWithFormat:@"%@份盒饭",object[@"Bento"]];
    PFFile *photo =shopveg[@"Photo"];
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
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];

        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [aiv stopAnimating];

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
    
}

- (IBAction)editAction:(UIBarButtonItem *)sender {
  // NSIndexPath *indexpath;
     [self.tableview setEditing:NO];
    if (self.edit.enabled==YES) {
        [self.edit setTitle:@"取消"];;
        [self.tableview setEditing:YES];
        //[self tableView:self.tableview didSelectRowAtIndexPath:indexpath];
            }
    if(self.edit.enabled==NO ){
        
        [self.tableview setEditing:NO];
        [self.edit setTitle:@"选择"];
        
           }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if( [self.edit.title isEqualToString:@"选择"] ){
//        [self.tableview setEditing:YES];
//        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//        [self.edit setTitle:@"取消"];
//        
//    }
//    else{
//        [self.tableview setEditing:NO];
//        [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
//        [self.edit setTitle:@"选择"];
//        
//    }
    //回到当前页面,取消刚刚的选项
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//下拉刷新
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
