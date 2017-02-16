//
//  SLSliderBar.m
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import "SLSliderBar.h"
#import "SLSliderItem.h"

#define DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define DEFAULT_SLIDER_COLOR [UIColor orangeColor]
#define SLIDER_VIEW_HEIGHT 2
#define SLIDER_VIEW_WIDTH 28

@interface SLSliderBar ()<SLSliderItemDelegate>
{
    SLSliderItem *_pleaseItem;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) UIView *sliderView;

@property (strong, nonatomic) SLSliderItem *selectedItem;
@property (strong, nonatomic) FDSlideBarItemSelectedCallback callback;

@end

@implementation SLSliderBar

#pragma mark - Lifecircle

- (instancetype)init {
    CGRect frame = CGRectMake(0, 20, DEVICE_WIDTH, BarDefaultHeight);
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        _currentIndex = 0;
        [self initScrollView];
        [self initSliderView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _items = [NSMutableArray array];
        _currentIndex = 0;
        [self initScrollView];
        [self initSliderView];
    }
    return self;
}

#pragma - mark Custom Accessors

- (void)setItemsTitle:(NSArray *)itemsTitle {
    _itemsTitle = itemsTitle;
    [self setupItems];
}

- (void)setItemColor:(UIColor *)itemColor {
    _itemColor = itemColor;
    for (SLSliderItem *item in _items) {
        [item setItemTitleColor:itemColor];
    }
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    _itemSelectedColor = itemSelectedColor;
    for (SLSliderItem *item in _items) {
        [item setItemSelectedTitleColor:itemSelectedColor];
    }
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    self.sliderView.backgroundColor = _sliderColor;
}

- (void)setSelectedItem:(SLSliderItem *)selectedItem {
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
}

- (void)setTipStr:(BOOL)tipStr{
    _tipStr = tipStr;
    if(_tipStr){
        [self addSelectItem];
    }
}

//- (void)addSelectItemWithDirection:(SLAnimationDirection)direction{
- (void)addSelectItem{
    CGFloat itemX = 15;
    CGFloat itemY = 12;
    if(_pleaseItem == nil){
        NSString *title = @"请选择";
        SLSliderItem *item = [[SLSliderItem alloc] init];
        item.delegate = self;
        CGFloat flatWith = [NSString autoWidthWithString:title Font:[UIFont systemFontOfSize:DEFAULT_TITLE_FONTSIZE]];
        item.frame = CGRectMake(itemX, itemY, flatWith, DEFAULT_TITLE_FONTSIZE+1);
        [item setItemTitleColor:_itemSelectedColor];
        [item setItemSelectedTitleColor:_itemSelectedColor];
        [item setItemTitle:title];
        _pleaseItem = item;
    }
    SLSliderItem *lastItem = [_items lastObject];
    itemX = CGRectGetMaxX(lastItem.frame)+itemX;
    
    [_items addObject:_pleaseItem];
    [_scrollView addSubview:_pleaseItem];
    
    itemX += CGRectGetMaxX(_pleaseItem.frame)+itemX;
    
    _scrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_scrollView.frame));
    //addAnimation
    [self updateSliderFrame];
    
    if(_items.count > 1){
        NSInteger index = [_items indexOfObject:_pleaseItem];
        if(_currentIndex != index){
            [self tipViewAnimation];
            _currentIndex = index;
        }
    }
}

#pragma - mark Private

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
}

- (void)initSliderView {
    //分割线
    float height = self.frame.size.height;
    UIView *fengeXian = [[UIView alloc]initWithFrame:CGRectMake(0, height-1, DEVICE_WIDTH, 1)];
    fengeXian.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [_scrollView addSubview:fengeXian];
    
    _sliderView = [[UIView alloc] init];
    _sliderColor = DEFAULT_SLIDER_COLOR;
    _sliderView.backgroundColor = _sliderColor;
    [_scrollView addSubview:_sliderView];
}

- (void)setupItems {
    for(SLSliderItem *item1 in _items){
        [item1 removeFromSuperview];
    }
    [_items removeAllObjects];
    
    CGFloat itemX = 15;
    for (int i=0; i<_itemsTitle.count; i++) {
        SLSliderItem *item = [[SLSliderItem alloc] init];
        item.delegate = self;
        
        // Init the current item's frame
        //        CGFloat itemW = [FDSlideBarItem widthForTitle:title];
        if ([_xinahsititle isEqualToString:average]) {
            CGFloat flatWith = [NSString autoWidthWithString:_itemsTitle[i] Font:[UIFont systemFontOfSize:DEFAULT_TITLE_FONTSIZE]];
            item.frame = CGRectMake(itemX, 12, flatWith, DEFAULT_TITLE_FONTSIZE+1);
        }else{
            item.frame = CGRectMake(itemX-15, 12, ScreenWidth/_itemsTitle.count,DEFAULT_TITLE_FONTSIZE+1);
        }
        [item setItemTitleColor:_itemColor];
        [item setItemSelectedTitleColor:_itemSelectedColor];
        [item setItemTitle:_itemsTitle[i]];
        [_items addObject:item];
        [_scrollView addSubview:item];
        
        // Caculate the origin.x of the next item
        itemX = CGRectGetMaxX(item.frame)+15;
        
    }
    
    // Cculate the scrollView 's contentSize by all the items
    _scrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_scrollView.frame));
    //
    if(_tipStr){
        [self addSelectItem];
    }
}

- (void)updateSliderFrame{
    // Set the default selected item, the first item

//    SLSliderItem *firstItem = [self.items objectAtIndex:_currentIndex];
    SLSliderItem *firstItem = _pleaseItem;
    firstItem.selected = YES;
    _selectedItem = firstItem;
    // Set the frame of sliderView by the selected item
    if(_sliderView.frame.origin.x == 0)
        _sliderView.frame = CGRectMake(firstItem.center.x-14, self.frame.size.height - SLIDER_VIEW_HEIGHT, SLIDER_VIEW_WIDTH, SLIDER_VIEW_HEIGHT);
}

- (void)scrollToVisibleItem:(SLSliderItem *)item {
    NSInteger selectedItemIndex = [self.items indexOfObject:_selectedItem];
    NSInteger visibleItemIndex = [self.items indexOfObject:item];
    
    // If the selected item is same to the item to be visible, nothing to do
    if (selectedItemIndex == visibleItemIndex) {
        return;
    }
    
    CGPoint offset = _scrollView.contentOffset;
    
    // If the item to be visible is in the screen, nothing to do
    if (CGRectGetMinX(item.frame) >= offset.x && CGRectGetMaxX(item.frame) <= (offset.x + CGRectGetWidth(_scrollView.frame))) {
        return;
    }
    
    // Update the scrollView's contentOffset according to different situation
    if (selectedItemIndex < visibleItemIndex) {
        // The item to be visible is on the right of the selected item and the selected item is out of screeen by the left, also the opposite case, set the offset respectively
        if (CGRectGetMaxX(_selectedItem.frame) < offset.x) {
            offset.x = CGRectGetMinX(item.frame);
        } else {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        }
    } else {
        // The item to be visible is on the left of the selected item and the selected item is out of screeen by the right, also the opposite case, set the offset respectively
        if (CGRectGetMinX(_selectedItem.frame) > (offset.x + CGRectGetWidth(_scrollView.frame))) {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        } else {
            offset.x = CGRectGetMinX(item.frame);
        }
    }
    _scrollView.contentOffset = offset;
}

//- (void)addAnimationWithSelectedItem:(SLSliderItem *)item {
- (void)addAnimationDistance:(CGFloat)dis {
    // Caculate the distance of translation
//    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    
    // Add the animation about translation
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_sliderView.layer.position.x);
    positionAnimation.toValue = @(_sliderView.layer.position.x + dis);
    
    // Add the animation about size
    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    boundsAnimation.keyPath = @"bounds.size.width";
    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    boundsAnimation.toValue = @(SLIDER_VIEW_WIDTH);
    
    // Combine all the animations to a group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, boundsAnimation];
    animationGroup.duration = 0.15;
    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    // Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dis, _sliderView.layer.position.y);
    CGRect rect = _sliderView.layer.bounds;
    rect.size.width = SLIDER_VIEW_WIDTH;
    _sliderView.layer.bounds = rect;
    //

}

- (void)tipViewAnimation{
    float offsetx = 15;
    SLSliderItem *item2 = _items[_items.count-2];

    CGRect rect = _pleaseItem.frame;
    rect.origin.x = CGRectGetMaxX(item2.frame)+offsetx;
    
    // Add the animation about translation
    CGFloat dx1 = CGRectGetMidX(rect) - CGRectGetMidX(_pleaseItem.frame);
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_pleaseItem.layer.position.x);
    positionAnimation.toValue = @(_pleaseItem.layer.position.x + dx1);
    
    // Add the animation about translation

    CGFloat dx = CGRectGetMidX(rect) - CGRectGetMidX(_sliderView.frame);
    CABasicAnimation *positionAnimation1 = [CABasicAnimation animation];
    positionAnimation1.keyPath = @"position.x";
    positionAnimation1.fromValue = @(_sliderView.layer.position.x);
    positionAnimation1.toValue = @(_sliderView.layer.position.x + dx);
    

    [_pleaseItem.layer addAnimation:positionAnimation forKey:@"helll boys"];
    _pleaseItem.layer.position = CGPointMake(_pleaseItem.layer.position.x + dx1, _pleaseItem.layer.position.y);
    
    [_sliderView.layer addAnimation:positionAnimation1 forKey:@"basic"];
    
    
    // Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    rect = _sliderView.layer.bounds;
    rect.size.width = SLIDER_VIEW_WIDTH;
    _sliderView.layer.bounds = rect;
}

#pragma mark - Public

- (void)slideBarItemSelectedCallback:(FDSlideBarItemSelectedCallback)callback {
    _callback = callback;
}

- (void)selectSlideBarItemAtIndex:(NSUInteger)index {
    _currentIndex = index;
    SLSliderItem *item = [self.items objectAtIndex:index];
    if (item == _selectedItem) {
        return;
    }
    
    item.selected = YES;
    [self scrollToVisibleItem:item];
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    [self addAnimationDistance:dx];
    self.selectedItem = item;
    
}

#pragma mark - FDSlideBarItemDelegate

- (void)slideBarItemSelected:(SLSliderItem *)item {
    if (item == _selectedItem) {
        return;
    }
    
    [self scrollToVisibleItem:item];
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    [self addAnimationDistance:dx];
    self.selectedItem = item;
    _currentIndex = [self.items indexOfObject:item];
    _callback(_currentIndex);
}

- (void)drawRect:(CGRect)rect{
    //阴影效果
    /*
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: UIColor.blackColor];
    [shadow setShadowOffset: CGSizeMake(0, -7.0)];
    [shadow setShadowBlurRadius: 5];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
    [color setFill];
    [rectanglePath fill];
    CGContextRestoreGState(context);
     */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
