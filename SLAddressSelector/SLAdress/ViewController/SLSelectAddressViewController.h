//
//  SLSelectAddressViewController.h
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLSelectAddressViewControllerDelegate <NSObject>
-(void)passSelectedCode:(int)provinceCode CityCode:(int)cityCode AreaCode:(int)areaCode  TownCode:(int)townCode AreaName:(NSString *)areaName;
@end

@interface SLSelectAddressViewController : UIViewController

@property (nonatomic, weak) id <SLSelectAddressViewControllerDelegate> delegate;

@end
