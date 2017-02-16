//
//  SLCityModel.m
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import "SLCityModel.h"

@implementation SLCityModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cities":[SLCityModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"_id":@"id"};
}
@end
