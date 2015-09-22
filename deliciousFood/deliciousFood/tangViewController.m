//
//  tangViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/22.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "tangViewController.h"
#import "caileiTableViewCell.h"
#import "firstcellViewController.h"
@interface tangViewController ()

@end

@implementation tangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self zaodian];
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
-(void)zaodian{
    PFQuery *query = [PFQuery queryWithClassName:@"Vegetables"];
    [query whereKey:@"Type" equalTo:@"汤"];
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectsForShow = returnedObjects;
            [self.tableview reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objectsForShow.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    caileiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *object=[self.objectsForShow objectAtIndex:indexPath.row
                      ];
    cell.foodname.text=object[@"Dishes"];
    cell.price.text=[NSString stringWithFormat:@"%@元",object[@"Price"]];
    cell.like.text=[NSString stringWithFormat:@"%@",object[@"Like"]];
    cell.Umlike.text=[NSString stringWithFormat:@"%@",object[@"Unlike"]];
    cell.jieshao.text=object[@"Discriptiondetail"];
    
    PFFile *photo =object[@"Photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageVi.image = image;
            });
        }
    }];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //回到当前页面,取消刚刚的选项
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
