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
        [self layout];
    }
    return self;
}

- (void)layout {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 1;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
