//
//  SLAddressCollectionViewCell.h
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLCityModel.h"
@interface SLAddressCollectionViewCell : UICollectionViewCell
@property(nonatomic ,strong) NSArray *dataSource;
@property(nonatomic ,strong) void (^getSelectedItem)(SLCityModel *model);
@end
