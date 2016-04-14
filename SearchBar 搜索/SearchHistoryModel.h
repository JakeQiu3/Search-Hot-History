//
//  SearchHistory.h
//  SearchDemo
//
//  Created by qsy on 15/12/25.
//  Copyright © 2015年 qsy. All rights reserved.
//
/**
 *  搜索历史记录管理，这个保存在本地
 */

#import <Foundation/Foundation.h>

@interface SearchHistoryModel : NSObject

+(SearchHistoryModel*)shareInstance;

/**
 *  获取历史搜索记录
 *
 */
-(NSMutableArray*)getSearchHistoryMArray;

/**
 *  清空搜索记录
 */
-(void)clearAllSearchHistory;


/*
 * 保存搜索历史到文件
 */
- (void)saveSearchItemHistory;

@end
