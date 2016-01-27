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

@interface SearchHistory : NSObject

+(SearchHistory*)shareInstance;

/**
 *  获取历史搜索记录
 *
 */
-(NSMutableArray*)getSearchHistoryMArray;

/**
 *  添加搜索记录
 *
 *  @param dic 搜索记录按字典添加
 */
-(void)addSearchHistoryWithDic:(NSDictionary*)dic;

/**
 *  清空搜索记录
 */
-(void)clearAllSearchHistory;


/*
 * 保存搜索历史到文件
 */
- (void)saveSearchItemHistory;
@end
