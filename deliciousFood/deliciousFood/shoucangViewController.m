//
//  shoucangViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "shoucangViewController.h"

@interface shoucangViewController ()

@end

@implementation shoucangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
//-(void)query
//{
//    PFQuery *query=[PFQuery queryWithClassName:@"Vegetables"];
//    [query includeKey:@"VegetablesFav"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *array,NSError *error){
//        if (!error) {
//            self.objectForShow = array;
//            [self.tableview reloadData];
//        }else {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _objectForShow.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   // PFObject *object=[self.objectForShow objectAtIndex:indexPath.row];
    
  //  PFObject *Favarites = object[@"FavaritesUser"];
    
    

    return cell;
    
}

@end
