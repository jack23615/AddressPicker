//
//  SLSelectAddressViewController.m
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import "SLSelectAddressViewController.h"
#import "SLAddressCollectionViewCell.h"
#import "SLSliderBar.h"


@interface SLSelectAddressViewController ()
{
    NSMutableArray *_titleArr;
    NSMutableArray *_addressItem;
    NSMutableArray *_areaModel;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collview1;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collecLayout1;
@property (weak, nonatomic) IBOutlet SLSliderBar *slideBar;
@property (weak, nonatomic) IBOutlet UIView *tapview;

@end

@implementation SLSelectAddressViewController
static NSString *identifier =@"SLAddressCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)addTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    [_tapview addGestureRecognizer:tap];
}

- (void)tapped{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initData{
    _titleArr = [[NSMutableArray alloc]init];
    _addressItem = [[NSMutableArray alloc]init];
    _areaModel = [[NSMutableArray alloc]init];
    //初始化省市区
    NSArray *arr = [SLStore getArea];
    if(arr.count == 0){
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
        [_addressItem addObject:mArr];
    }else{
        [_addressItem addObject:arr];
    }
    //添加手势
    [self addTapGesture];
}

- (void)initUI{
    //
    _slideBar.xinahsititle = average;
    _slideBar.backgroundColor = [UIColor whiteColor];
    _slideBar.itemColor = SLColor(204,204,204);
    _slideBar.itemSelectedColor = SLColor(51, 51, 51);
    _slideBar.sliderColor = SLColor(51, 51, 51);
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        [self selectedIndex:idx];
    }];
    _slideBar.tipStr = YES;
    //
    [self setCollection];
    
    [_collview1 reloadData];
}

#pragma mark -- 如果存在_model.sublevel 则使用下面的界面来显示
- (void)setCollection{
    [self.collview1 registerNib:[UINib nibWithNibName:@"SLAddressCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

//#pragma mark -- 九宫格代理相关
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _addressItem.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SLAddressCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.dataSource = _addressItem[indexPath.row];
    cell.getSelectedItem = ^(SLCityModel *model){

        NSInteger count = _titleArr.count;
        for(NSInteger i = indexPath.row ;i<count;i++){
            [_titleArr removeObjectAtIndex:indexPath.row];
            [_areaModel removeObjectAtIndex:indexPath.row];
        }
        count = _addressItem.count;
        for(NSInteger i = indexPath.row+1 ;i<count;i++){
            [_addressItem removeObjectAtIndex:indexPath.row+1];
        }
        [_titleArr addObject:model.name];
        [_areaModel addObject:model];
        if(model.cities.count)
            [_addressItem addObject:model.cities];
        else{
            [self passValue];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            return ;
        }
        
        [_slideBar setItemsTitle:_titleArr];
        [_collview1 reloadData];
        [_collview1 setContentOffset:CGPointMake((indexPath.row+1)*ScreenWidth,_collview1.contentOffset.y) animated:YES];
    };
    return cell;
}
//设置每个格子的宽度和高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth, self.collview1.frame.size.height);;
}

#pragma mark -scrollviewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x/scrollView.frame.size.width;
//     获取这一点的indexPath
    [self.slideBar selectSlideBarItemAtIndex:index];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index
{
    [_collview1 setContentOffset:CGPointMake(index*ScreenWidth,_collview1.contentOffset.y) animated:YES];
}

#pragma mark - private

- (void)passValue{
    NSMutableArray *arr = [NSMutableArray array];
    for(NSString *str in _titleArr){
        if(![arr containsObject:str])
            [arr addObject:str];
    }
    NSString *area = [arr componentsJoinedByString:@""];
    if(_areaModel.count == 4){
        SLCityModel *Model = _areaModel[0];
        int provinceCode = Model._id;
        Model = _areaModel[1];
        int cityCode = Model._id;
        Model = _areaModel[2];
        int areaCode = Model._id;
        Model = _areaModel[3];
        int townCode = Model._id;
        if([_delegate respondsToSelector:@selector(passSelectedCode:CityCode:AreaCode:TownCode:AreaName:)]){
            [_delegate passSelectedCode:provinceCode CityCode:cityCode AreaCode:areaCode TownCode:townCode AreaName:area];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
