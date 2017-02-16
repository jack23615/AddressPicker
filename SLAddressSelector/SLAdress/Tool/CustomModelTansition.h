//
//  CustomModelTansition.h
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomModelTansition : UIPercentDrivenInteractiveTransition<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,UIGestureRecognizerDelegate>
//---设置是否可拖拽（默认：不可拖动）
@property (nonatomic, assign, getter=isDragable) BOOL dragable;
//---初始化 model视图控制器
- (id)initWithModalViewController:(UIViewController *)modalViewController;
@end
