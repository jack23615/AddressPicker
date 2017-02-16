//
//  SLSliderBar.h
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BarDefaultHeight 44
#define average @"average"

typedef void(^FDSlideBarItemSelectedCallback)(NSUInteger idx);

@interface SLSliderBar : UIView

// All the titles of FDSilderBar
@property (copy, nonatomic) NSArray *itemsTitle;

// All the item's text color of the normal state
@property (strong, nonatomic) UIColor *itemColor;

// The selected item's text color
@property (strong, nonatomic) UIColor *itemSelectedColor;

// The slider color
@property (strong, nonatomic) UIColor *sliderColor;

@property (nonatomic ,assign) NSInteger currentIndex;

// Add the callback deal when a slide bar item be selected
- (void)slideBarItemSelectedCallback:(FDSlideBarItemSelectedCallback)callback;

// Set the slide bar item at index to be selected
- (void)selectSlideBarItemAtIndex:(NSUInteger)index;

@property(nonatomic,copy)NSString *xinahsititle;

/**
 是否包含提示
 */
@property (nonatomic ,assign) BOOL tipStr;

@end
