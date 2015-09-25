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
    PFQuery *query = [PFQuery queryWithClassName:@"Booking"];
    [query includeKey:@"BookingUser"];
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectArray = [[NSMutableArray alloc] initWithArray:returnedObjects];

            //NSLog(@"objectArray = %@",self.objectArray);
            [self.tableview reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    // Do any additional setup after loading the view.
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
    //PFUser *currentuser = [PFUser currentUser];
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
    cell.times.text=[object.createdAt description];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
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



@end
