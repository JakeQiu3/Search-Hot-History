//
//  SearchHistory.m
//  SearchDemo
//
//  Created by qsy on 15/12/25.
//  Copyright © 2015年 qsy. All rights reserved.
//

/// 历史记录保存路径
#define ASETTING_SEARCH_ITEM_FILE_NAME @"/searchItemHistory.txt"

#import "SearchHistory.h"

static SearchHistory *searchHistory = nil;

@interface SearchHistory ()

/**
 *  搜索历史
 */
@property (nonatomic, strong) NSMutableArray *searchHistoryMArray;


@end

@implementation SearchHistory

+(SearchHistory*)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == searchHistory) {
            searchHistory = [[SearchHistory alloc] init];
        }
    });
    
    return searchHistory;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *searchStockPath = [path stringByAppendingPathComponent:ASETTING_SEARCH_ITEM_FILE_NAME];
        
        NSArray *fileArray = [NSMutableArray arrayWithContentsOfFile:searchStockPath];
        self.searchHistoryMArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *d in fileArray)
        {
            if (nil != d)
            {
                [self.searchHistoryMArray addObject:d];
            }
        }

    }
    
    return self;
}

-(void)addSearchHistoryWithDic:(NSDictionary*)dic {
    if (nil == dic) return;
    NSInteger index = [[SearchHistory shareInstance].searchHistoryMArray indexOfObject:dic];
    if (index == NSNotFound || -1 == index) {
        [[SearchHistory shareInstance].searchHistoryMArray insertObject:dic atIndex:0];
    } else {
        // 存在
    }
    [[SearchHistory shareInstance] saveSearchItemHistory];
}

-(void)clearAllSearchHistory {
    [[SearchHistory shareInstance].searchHistoryMArray removeAllObjects];
    [[SearchHistory shareInstance] saveSearchItemHistory];
}

-(NSMutableArray*)getSearchHistoryMArray {
    return [SearchHistory shareInstance].searchHistoryMArray;
}

//保存历史记录
- (void)saveSearchItemHistory
{
    NSMutableArray *fileArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in self.searchHistoryMArray) {
        [fileArray addObject:dic];
    }
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    path = [path stringByAppendingPathComponent:ASETTING_SEARCH_ITEM_FILE_NAME];
    [fileArray writeToFile:path atomically:YES];
}

#pragma mark =====
-(NSMutableArray *)searchHistoryMArray{
    if (!_searchHistoryMArray) {
        _searchHistoryMArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _searchHistoryMArray;
}

@end
