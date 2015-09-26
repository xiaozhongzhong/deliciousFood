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
- (IBAction)menuAction:(UIBarButtonItem *)sender;

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@"login"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
    [self requestData];
    [self uiConfiguration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestData {
    PFQuery *query = [PFQuery queryWithClassName:@"Vegetables"];
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [aiv startAnimating];
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


//当回到页面时执行下面的通知
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //点击执行ViewController里面的一个通知(打开手势的通知)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enablePanGes" object:self];
}
//当离开页面时执行下面的通知
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //点击执行ViewController里面的一个通知(关闭手势的通知)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disablePanGes" object:self];
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
    [_TabV addSubview:refreshControl];
    
}
- (void)refreshData:(UIRefreshControl *)rc
{
    [self requestData];
    [_TabV reloadData];
    //怎么样让方法延迟执行的
    [self performSelector:@selector(endRefreshing:) withObject:rc];//afterDelay:1.f];
}
- (void)endRefreshing:(UIRefreshControl *)rc {
    // [self query];
    //[_tableView reloadData];
    [rc endRefreshing];//闭合
}



- (IBAction)zaodian:(UIButton *)sender forEvent:(UIEvent *)event {
      // [self performSegueWithIdentifier:@"zaodian" sender:self];
}

- (IBAction)caociaAction:(UIButton *)sender forEvent:(UIEvent *)event {
   
}

- (IBAction)tangAction:(UIButton *)sender forEvent:(UIEvent *)event {
   
}

- (IBAction)yeAction:(UIButton *)sender forEvent:(UIEvent *)event {
   }

- (IBAction)menuAction:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"leftSwitch" object:self];
}
@end
