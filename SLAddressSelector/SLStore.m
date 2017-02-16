//
//  SLStore.m
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import "SLStore.h"
#import "SLCityModel.h"

@implementation SLStore

+ (void)initArea{
    dispatch_queue_t queu = dispatch_queue_create("createProvince", 0);
    dispatch_async(queu, ^{
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([JsonObject isKindOfClass:[NSArray class]]){
            NSArray *arr = (NSArray*)JsonObject;
            for(id object in arr){
                SLCityModel *model = [SLCityModel mj_objectWithKeyValues:object];
                [mArr addObject:model];
            }
        }
        _selectArea = mArr;
    });
    
}

+ (NSArray*)getArea{
    return _selectArea;
}
@end
