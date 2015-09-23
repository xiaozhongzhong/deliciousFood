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
@interface secondViewController ()
- (IBAction)jiesuanAction:(UIBarButtonItem *)sender;


@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self query];
    // Do any additional setup after loading the view.
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
-(void)query
{
    PFQuery *query=[PFQuery queryWithClassName:@"Shoppingcart"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array,NSError *error){
        if (!error) {
            self.objectForShow = array;
            NSLog(@"%@",array);
            [self.tableview reloadData];
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
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


- (IBAction)jiesuanAction:(UIBarButtonItem *)sender {
}
@end
