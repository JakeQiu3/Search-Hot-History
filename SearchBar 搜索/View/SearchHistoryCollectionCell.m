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
        [self layout];
    }
    return self;
}

- (void)layout {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 1;
    [self.contentView addSubview:titleLabel];
     self.titleLabel = titleLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
