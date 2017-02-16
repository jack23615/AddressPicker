//
//  SLCityModel.h
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLCityModel : NSObject
@property(nonatomic ,strong) NSString *name;
@property(nonatomic ,assign) int _id;
@property(nonatomic ,strong) NSArray *cities;
@end
