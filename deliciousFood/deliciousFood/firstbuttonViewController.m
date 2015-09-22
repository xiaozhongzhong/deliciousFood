//
//  firstbuttonViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "firstbuttonViewController.h"
#import "caileiTableViewCell.h"

@interface firstbuttonViewController ()

@end

@implementation firstbuttonViewController

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
    //[query selectKeys:@[@"Type"]];
   // NSLog(@"%@",query);
    //[query includeKey:@"Type"];
    
    [query whereKey:@"Type" equalTo:@"早点"];
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectsForShow = returnedObjects;
            //NSLog(@"ttt=%@", _objectsForShow);
            [_tableview reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
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
    //return 1;
    return self.objectsForShow.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    caileiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *object=[self.objectsForShow objectAtIndex:indexPath.row
                      ];
    NSLog(@"%@",object);
//    PFObject *type=object[@"Type"];
//    NSLog(@"%@",type);
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


@end
