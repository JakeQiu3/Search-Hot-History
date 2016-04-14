//
//  SearchBarView.h
//  PManager
//  搜索框
//  Created by QSY on 14-7-4.
//  Copyright (c) 2014年 Huoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchBarViewDelegate <NSObject>

@optional
/**
 搜索框开始编辑
 */
- (void)searchBarFieldDidBeginEditing:(UISearchBar *)searchBar;

/**
 搜索框结束编辑
 */
- (void)searchBarFieldDidEndEditing:(UISearchBar *)searchBar;

/**
 搜索框搜索按钮点击事件
 */
- (void)searchBarFieldButtonClicked:(UISearchBar *)searchBar;

/**
 搜索框更新编辑
 */
- (void)searchBarFieldChangeEditing:(NSString *)searchText;

@end

@interface SeaSaleSearchBarView : UIView <UITextFieldDelegate, UISearchBarDelegate>
{
@private
    UIButton *searchButton;
    
//    UISearchBar *_searchBar;
    
    NSString *_placeHolder;
    
    struct {
        unsigned int didBeginEdit          : 1;
        unsigned int didEndEdit            : 1;
        unsigned int didClicked            : 1;
        unsigned int didChangeEdit         : 1;
    } _delegateFlags;// delegate 响应标识
}

/**
 *  searchBarDelegate
 */
@property (nonatomic, assign) id<SearchBarViewDelegate>delegate;

/** searchBar's text content */
@property (nonatomic, copy) NSString *searchContentKey;

@property (nonatomic, copy) UISearchBar *searchBar;;
/**
 * the normalState searchBtnImage
 */
@property (nonatomic, copy) NSString *searchBtnImage;

/**
 * the highlightedState searchBtnImage
 */
@property (nonatomic, copy) NSString *searchBtnImagePress;


/**
 * 重写初始化方法，加入代理
 */
- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
                     Delegate:(id<SearchBarViewDelegate>)delegate;
@end
