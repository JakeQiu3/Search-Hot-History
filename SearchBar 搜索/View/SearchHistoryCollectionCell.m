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
        NSLog(@"%@",NSStringFromCGRect(_titleLabel.frame));
//        _titleLabel.backgroundColor = [UIColor greenColor];
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
