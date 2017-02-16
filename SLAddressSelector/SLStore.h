//
//  SLStore.h
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSArray *_selectArea;

@interface SLStore : NSObject

/**
 初始化省市区
 */
+ (void)initArea;

/**
 获取省市区
 
 @return 返回数据
 */
+ (NSArray*)getArea;
@end
