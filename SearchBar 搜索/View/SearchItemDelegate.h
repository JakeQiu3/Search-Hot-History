//
//  SearchItemDelegate.h
//  SearchBar 搜索
//
//  Created by 邱少依 on 16/4/14.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ClickCollectionItem) {
    ClickCollectionItemHot = 0,         // 点击的是热门
    ClickCollectionItemHistory         // 点击的搜索历史
};

@protocol SearchItemDelegate <NSObject>

@optional

#pragma mark 点击热门搜索和历史搜索的代理方法
- (void)searchItemClickHotItem:(NSString *) itemName collectionItem:(ClickCollectionItem )collectionItem;

- (void)searchBarResignWhenScroll;

@end
