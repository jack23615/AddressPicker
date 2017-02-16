//
//  SLMainViewController.m
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import "SLMainViewController.h"
#import "SLSelectAddressViewController.h"
#import "CustomModelTansition.h"

@interface SLMainViewController ()<SLSelectAddressViewControllerDelegate>
- (IBAction)clickBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) CustomModelTansition *transition;
@end

@implementation SLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)clickBtn:(id)sender {
    //---初始化要弹出跳转的视图控制器
    SLSelectAddressViewController *modalVC = [SLSelectAddressViewController new];
    //---必须强引用，否则会被释放，自定义dismiss的转场无效
    self.transition = [[CustomModelTansition alloc]initWithModalViewController:modalVC];
    modalVC.transitioningDelegate = self.transition;
    //---必须添加这句.自定义转场动画
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    modalVC.delegate = self;
    [self presentViewController:modalVC animated:YES completion:nil];
}

#pragma maek - selectCityDelegate

- (void)passSelectedCode:(int)provinceCode CityCode:(int)cityCode AreaCode:(int)areaCode TownCode:(int)townCode AreaName:(NSString *)areaName{

    [_btn setTitle:areaName forState:UIControlStateNormal];
}
@end
