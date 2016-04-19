//
//  SearchHistoryCollectionCell.m
//  VinuxPost
//
//  Created by qsy on 15/12/30.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "SearchHistoryCollectionCell.h"

@interface SearchHistoryCollectionCell ()

@end


@implementation SearchHistoryCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.backgroundColor = DefaultColor;
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
        //2016-04-20 00:44:53.058 SearchBar 搜索[2683:99297] {{0, 0}, {117.9296875, 30}}
//        2016-04-20 00:44:58.172 SearchBar 搜索[2683:99297] Logging only once for UICollectionViewFlowLayout cache mismatched frame
//            2016-04-20 00:44:58.172 SearchBar 搜索[2683:99297] UICollectionViewFlowLayout has cached frame mismatch for index path <NSIndexPath: 0xc000000000200116> {length = 2, path = 1 - 1} - cached value: {{137.9296875, 235}, {49.53125, 30}}; expected value: {{148.33333333333334, 235}, {49.53125, 30}}
//        2016-04-20 00:44:58.172 SearchBar 搜索[2683:99297] This is likely occurring because the flow layout subclass SHFlowLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
//        Logging only once for UICollectionViewFlowLayout cache mismatched frame
// 仅仅走了第1次
        NSLog(@"%@",NSStringFromCGRect(_titleLabel.frame));
        _titleLabel.backgroundColor = [UIColor greenColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
