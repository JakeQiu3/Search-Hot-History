//
//  SearchHistoryView.m
//  VinuxPost
//
//  Created by qsy on 15/12/30.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "SearchHistoryAndHotView.h"
#import "SHFlowLayout.h"
#import "SearchHistoryCollectionCell.h"
#import "SearchHistoryModel.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SectionHeaderFooterWH 35
static CGFloat const margin = 10;

static NSString *const itemCollectionIdentifier =  @"itemCollection";
static NSString *const headerCollectionIdentifier = @"headerCollection";
static NSString *const footerCollectionIdentifier = @"footerCollection";

@interface SearchHistoryAndHotView() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    SHFlowLayout *_layout;
    NSMutableArray *_hotArray;//热门数组
    NSMutableArray *_historyArray;//历史数组
//    NSMutableArray *_newHistoryArray;//倒序处理后的的历史数组：数据源
}

@end

@implementation SearchHistoryAndHotView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self addAllData];
        [self setupCollectionView];
    }
    return self;
}

- (void)addAllData {
    
    _hotArray = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:@"Apple新品",@"iphone 6S",@"厨房餐拒绝",@"4K电视",@"回家结婚",@"美的空调",@"洗发水",@"美的空调",@"iphone 6S",@"4K电视",nil]];

    _historyArray = [[SearchHistoryModel shareInstance] getSearchHistoryMArray];
//    //   反向迭代器：原数组不变
//    NSEnumerator *enumerator = [_historyArray reverseObjectEnumerator];
//    id objc;
//    while (objc =[enumerator nextObject]) {
//        [_newHistoryArray addObject:objc];
//    }
}

- (void)setupCollectionView {
   
    _layout = [[SHFlowLayout alloc]init];
    _layout.minimumInteritemSpacing = margin;
    _layout.minimumLineSpacing = margin;
    _layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, SectionHeaderFooterWH);
    _layout.footerReferenceSize = CGSizeMake(SCREENWIDTH, SectionHeaderFooterWH);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _collectionView.scrollEnabled = YES;
    _collectionView.backgroundColor = DefaultColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    [self registerIdentifier];
}

- (void)registerIdentifier {
    [_collectionView registerClass:[SearchHistoryCollectionCell class] forCellWithReuseIdentifier:itemCollectionIdentifier];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectionIdentifier];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier];

}

#pragma mark -- collection数据源代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _hotArray.count;
    }else{
        if (_historyArray.count >10) {
            return 10;
        } else return _historyArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchHistoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCollectionIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleLabel.text = _hotArray[indexPath.item];
    } else {
        cell.titleLabel.text = _historyArray[indexPath.item];
    }
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(15, margin, -10, margin);
    } return UIEdgeInsetsMake(15, margin, 15,margin);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
 
    if (kind == UICollectionElementKindSectionHeader) { //头部视图
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerCollectionIdentifier forIndexPath:indexPath];
            if (indexPath.section == 0) {
//               添加背景视图的父视图
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, headerView.bounds.size.width+10, SectionHeaderFooterWH)];
                backView.backgroundColor = [UIColor whiteColor];
                [headerView addSubview:backView];
                
                //    添加头部标题
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH/2, SectionHeaderFooterWH)];
                label.text = @"热门搜索";
                [backView addSubview:label];
            } else {
                UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, headerView.bounds.size.width, SectionHeaderFooterWH)];
                backgroundView.backgroundColor = [UIColor whiteColor];
                [headerView addSubview:backgroundView];
                //   新增头部标题
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.bounds.size.width, 30)];
                label.text = @"历史搜索";
                [backgroundView addSubview:label];
                //    添加清除历史的button
                UIButton *btn = [[UIButton alloc] init];
                btn.frame = CGRectMake(SCREENWIDTH-60-10, 0, 60, SectionHeaderFooterWH);
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                [btn setTitle:@"清除历史" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [btn setTitle:@"清除历史" forState:UIControlStateHighlighted];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(clearBtn:) forControlEvents:UIControlEventTouchUpInside];
                [backgroundView addSubview:btn];

            }
        return headerView;
    } else { //脚部视图
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier forIndexPath:indexPath];
        footerView.frame = CGRectZero;
        return footerView;
    }

}
// 清除历史记录
- (void)clearBtn:(UIButton *)btn {
//   清除存储的数据源
    [[SearchHistoryModel shareInstance] clearAllSearchHistory];
    [[SearchHistoryModel shareInstance] saveSearchItemHistory];
    
    [_historyArray removeAllObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    });
}

//根据文字大小计算不同item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        size  = [_hotArray[indexPath.item] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        
    }else {
        size  = [_historyArray[indexPath.item] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        
    }
    return  CGSizeMake(size.width+10, 30);
}

//点击item的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//         NSLog(@"点击热门:%@",_hotArray[indexPath.item]);
        if (self.searchHotAndHistoryDelegate && [self.searchHotAndHistoryDelegate respondsToSelector:@selector(searchItemClickHotItem: collectionItem:)]) {
            [_searchHotAndHistoryDelegate searchItemClickHotItem:_hotArray[indexPath.item] collectionItem:ClickCollectionItemHot];
        }
    } else {
//        NSLog(@"点击搜索历史:%@",_newHistoryArray[indexPath.item]);
        if (self.searchHotAndHistoryDelegate && [self.searchHotAndHistoryDelegate respondsToSelector:@selector(searchItemClickHotItem:collectionItem:)]) {
            [_searchHotAndHistoryDelegate searchItemClickHotItem:_historyArray[indexPath.item] collectionItem:ClickCollectionItemHistory];
        }
    }
}



@end
