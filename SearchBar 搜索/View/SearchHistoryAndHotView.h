//
//  SearchHistoryView.h
//  VinuxPost
//
//  Created by qsy on 15/12/30.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchItemDelegate.h"
@interface SearchHistoryAndHotView : UIScrollView

@property (nonatomic, weak) id<SearchItemDelegate> searchHotAndHistoryDelegate;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
