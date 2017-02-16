//
//  SLSliderItem.h
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DEFAULT_TITLE_FONTSIZE 14
#define DEFAULT_TITLE_SELECTED_FONTSIZE 14
@protocol SLSliderItemDelegate;

@interface SLSliderItem : UIView
@property (assign, nonatomic) BOOL selected;
@property (weak, nonatomic) id<SLSliderItemDelegate> delegate;

- (void)setItemTitle:(NSString *)title;
- (void)setItemTitleFont:(CGFloat)fontSize;
- (void)setItemTitleColor:(UIColor *)color;
- (void)setItemSelectedTileFont:(CGFloat)fontSize;
- (void)setItemSelectedTitleColor:(UIColor *)color;

+ (CGFloat)widthForTitle:(NSString *)title;

@end

@protocol SLSliderItemDelegate <NSObject>

- (void)slideBarItemSelected:(SLSliderItem *)item;

@end
