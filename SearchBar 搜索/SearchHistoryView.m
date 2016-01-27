//
//  SearchHistoryView.m
//  VinuxPost
//
//  Created by wangfh on 15/12/30.
//  Copyright © 2015年 Ricky. All rights reserved.
//

#import "SearchHistoryView.h"
#import "RickyConst.h"
#import "FHFlowLayout.h"
#import "SearchHistoryCollectionCell.h"
#import "SearchHistory.h"

static CGFloat const margin = 5;
static CGFloat const lineCount = 2;

static NSString *const itemCollection =  @"itemCollection";
static NSString *const headCollection = @"headCollection";

@interface SearchHistoryView() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
//    UICollectionViewFlowLayout *_layout;
    FHFlowLayout *_layout;
    NSMutableArray *_hotArray;
    NSMutableArray *_historyArray;
}
@end

@implementation SearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initData];
        [self setupCollectionView];
    }
    return self;
}
- (void)initData {
    _hotArray = @[].mutableCopy;
    _hotArray = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:@"家电的",@"对方的说法",@"舍得放开舍得放开",@"是",@"都结婚后很快就回家看很",@"舍得舍得放开",@"舍得放开舍得放开",@"舍得放开舍得放开", nil]];

    _historyArray = [[SearchHistory shareInstance] getSearchHistoryMArray];
    
    [[SearchHistory shareInstance]saveSearchItemHistory];
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
}

- (void)setupCollectionView {
   
    _layout = [[FHFlowLayout alloc]init];
    _layout.minimumInteritemSpacing = margin;
    _layout.minimumLineSpacing = margin;
    _layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 30);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = DefaultColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"SearchHistoryCollectionCell" bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:itemCollection];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headCollection];
    [self addSubview:_collectionView];
}

#pragma mark -- collection数据源代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _hotArray.count;
    }else return _historyArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchHistoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCollection forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    if (indexPath.section == 0) {
        cell.titleLabel.text = _hotArray[indexPath.item];
    }else {
        cell.titleLabel.text = _historyArray[indexPath.item];
    }
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(35, margin, 35,margin);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headCollection forIndexPath:indexPath ];
    headerView.backgroundColor= [UIColor whiteColor];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5/2, 25, 25)];
    icon.image = indexPath.section == 0?[UIImage imageNamed:@"iconfont-remen"]:[UIImage imageNamed:@"iconfont-lishi"];
    [headerView addSubview:icon];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, SCREENWIDTH/2, 30)];
    label.text = indexPath.section == 0? @"热门搜索":@"历史搜索";
    if (indexPath.section == 1) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(SCREENWIDTH-50-30, 0, 60, 30);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:@"清除历史" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTitle:@"清除历史" forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clearBtn) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    }
    [headerView addSubview:label];
    return headerView;
}
- (void)clearBtn {
    [[SearchHistory shareInstance] clearAllSearchHistory];
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGSize size  = MB_TEXTSIZE(_hotArray[indexPath.item],[UIFont systemFontOfSize:13]);
        return  CGSizeMake(size.width+10, 30);
    }else {
        CGSize size  = MB_TEXTSIZE(_historyArray[indexPath.item],[UIFont systemFontOfSize:13]);
        return  CGSizeMake(size.width+10,30);
    }
}
//点击item的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"点击热门");
    } else {
        NSLog(@"点击搜索历史");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
