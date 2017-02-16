//
//  SLAddressCollectionViewCell.m
//  SLAddressSelector
//
//  Created by sks on 17/2/16.
//  Copyright © 2017年 Jack_Code. All rights reserved.
//

#import "SLAddressCollectionViewCell.h"
#import "SLAddressTableViewCell.h"

@interface SLAddressCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation SLAddressCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_tableview registerNib:[UINib nibWithNibName:@"SLAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"SLAddressTableViewCell"];
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [_tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SLAddressTableViewCell" forIndexPath:indexPath];
    SLCityModel *m = _dataSource[indexPath.row];
    cell.cellTitle.text = m.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_getSelectedItem)
        _getSelectedItem(_dataSource[indexPath.row]);
}

@end
