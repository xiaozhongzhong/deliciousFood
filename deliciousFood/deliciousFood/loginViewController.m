//
//  loginViewController.m
//  deliciousFood
//
//  Created by admin1 on 15/9/21.
//  Copyright (c) 2015年 admin1. All rights reserved.
//

#import "loginViewController.h"
#import "resiveViewController.h"

@interface loginViewController ()

- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

/*
-(void)popUpHomePage{
    TapViewController *tabVC=[Utilities getStoryboardInstanceByIdentity:@"tap"];
    //创建导航控制器
    UINavigationController* naviVC = [[UINavigationController alloc] initWithRootViewController:tabVC];
    //导航条隐藏
    naviVC.navigationBarHidden = YES;
    self.slidingViewController =[ECSlidingViewController slidingWithTopViewController:naviVC];
    //左滑与右滑默认时间
    _slidingViewController.defaultTransitionDuration = 0.25;
    //设置手势（触摸与拖拽）
    _slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    //增加手势到View
    [naviVC.view addGestureRecognizer:self.slidingViewController.panGesture];
    LeftViewController *leftVC = [Utilities getStoryboardInstanceByIdentity:@"Left"];
    
    
    //设置滑动的页面
    _slidingViewController.underLeftViewController = leftVC;
    //当滑出左侧菜单时，中间页面左边到屏幕右边的距离
    _slidingViewController.anchorRightPeekAmount = UI_SCREEN_W /2;
    //anchorLeftpeekAmount:当滑出右侧菜单时，中间页面右边到屏幕左边的距离
    //下面是三个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftSwitchAction) name:@"leftSwitch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablePanGesOnSliding) name:@"enablePanGes" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablePanGesOnSliding) name:@"disablePanGes" object:nil];
    
    
    [self presentViewController:self.slidingViewController animated:YES completion:nil];
 
}
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)resiveAction:(UIButton *)sender forEvent:(UIEvent *)event {
//    [self performSegueWithIdentifier:@"toResice" sender:self];
//
//}
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
}
@end
