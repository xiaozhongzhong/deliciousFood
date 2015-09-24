//
//  LeftViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/22.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "LeftViewController.h"
#import "passwordViewController.h"
@interface LeftViewController ()
- (IBAction)usenameAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)passwordAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)adressAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)tuichiAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image=[UIImage imageNamed:@"5.png"];
    self.view.layer.contents=(__bridge id)(image.CGImage);
    self.view.layer.backgroundColor=[UIColor clearColor].CGColor;
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"2.png"]];
    [self readingUsername];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)readingUsername{
    //读取用户名
    PFUser *currentUser = [PFUser currentUser];
    self.username.text=[NSString stringWithFormat:@"账号信息：%@",currentUser[@"username"]];
    PFFile *photo =currentUser[@"TouXiang"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageview.image = image;
                //NSLog(@"%@",image);
            });
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self readingUsername];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   
        if (alertView.tag == 9001) {
    if (buttonIndex==1) {
            [self readingUsername];
            UITextField *textField = [alertView textFieldAtIndex:0];
        
            if ([textField.text isEqualToString:@""]||[textField.text isEqualToString:self.username.text]) {
                [Utilities popUpAlertViewWithMsg:@"你输入的用户名为空或重复" andTitle:nil]
                ;
                return;
            }
            PFUser *user=[PFUser currentUser];
            user[@"username"]=textField.text;
            user[@"Address"]=textField.text;
            UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [aiv stopAnimating];
                if (succeeded) {
                    [Utilities setUserDefaults:@"userName" content:textField.text];
                    [Utilities popUpAlertViewWithMsg:@"修改用户名成功" andTitle:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    [self readingUsername];
                    
                } else {
                    [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                }
            }];
        }
    } else {
        if (buttonIndex==1) {
            [self readingUsername];
            UITextField *textField = [alertView textFieldAtIndex:0];
           
            if ([textField.text isEqualToString:@""]||[textField.text isEqualToString:self.username.text]) {
                [Utilities popUpAlertViewWithMsg:@"你输入的地址为空或重复" andTitle:nil]
                ;
                return;
            }
            PFUser *user=[PFUser currentUser];
            user[@"Address"]=textField.text;
            UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [aiv stopAnimating];
                if (succeeded) {
                    [Utilities popUpAlertViewWithMsg:@"修改地址成功" andTitle:nil];
                    [self.navigationController popViewControllerAnimated:YES];

                } else {
                    [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                }
            }];
        }
        }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
   }


- (IBAction)usenameAction:(UIButton *)sender forEvent:(UIEvent *)event {
    UIAlertView *sellView = [[UIAlertView alloc]initWithTitle:@"警告" message:[NSString stringWithFormat:@"修改的用户名是：%@\n请输入你修改后的用户名",self.username.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [sellView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    sellView.tag = 9001;
        [sellView show];

}

- (IBAction)passwordAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self performSegueWithIdentifier:@"pass" sender:self];
}

- (IBAction)adressAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *currentUser = [PFUser currentUser];
    NSString *address;
    address = currentUser[@"Address"];
    UIAlertView *sellView = [[UIAlertView alloc]initWithTitle:@"修改地址" message:[NSString stringWithFormat:@"修改的地址是：%@\n请输入你修改后的地址",address] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [sellView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    sellView.tag = 8001;
    [sellView show];
    
}


- (IBAction)tuichiAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)pickAction:(UITapGestureRecognizer *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet setExclusiveTouch:YES];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        if (buttonIndex == 2)
            return;
        
        UIImagePickerControllerSourceType temp;
        if (buttonIndex == 0) {
            temp = UIImagePickerControllerSourceTypeCamera;
        } else if (buttonIndex == 1) {
            temp = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        if ([UIImagePickerController isSourceTypeAvailable:temp]) {
            _imagePickerController = nil;
            _imagePickerController = [[UIImagePickerController alloc] init];
            _imagePickerController.delegate = self;
            _imagePickerController.allowsEditing = YES;
            _imagePickerController.sourceType = temp;
            [self presentViewController:_imagePickerController animated:YES completion:nil];
        } else {
            if (temp == UIImagePickerControllerSourceTypeCamera) {
                [Utilities popUpAlertViewWithMsg:@"当前设备无照相功能" andTitle:nil];
            }
        }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    _imageview.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    NSData *photoData = UIImagePNGRepresentation(_imageview.image);
    PFFile *photoFile = [PFFile fileWithName:@"2.png" data:photoData];
    PFUser *user = [PFUser currentUser];
    //PFObject *user = [PFObject objectWithClassName:@"_User"];
    user[@"TouXiang"] = photoFile;
  //  NSLog(@"%@",user[@"TouXiang"]);
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiv.frame = self.view.bounds;
    [self.view addSubview:aiv];
    [aiv startAnimating];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        [aiv stopAnimating];
        if (succeeded) {
            [Utilities popUpAlertViewWithMsg:@"保存成功" andTitle:nil];
            
        } else {
            NSLog(@"%@", [error description]);
        }
        
    }];

}


@end
