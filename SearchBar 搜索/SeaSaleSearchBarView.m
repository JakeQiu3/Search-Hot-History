//
//  SearchBarView.m
//  PManager
//
//  Created by qsy on 14-7-4.
//  Copyright (c) 2014年 Huoli. All rights reserved.
//

#import "SeaSaleSearchBarView.h"

static const CGFloat margin = 5;

@interface SeaSaleSearchBarView ()

@end

@implementation SeaSaleSearchBarView

/*
 instancetype is a contextual keyword that is only permitted in the result type of an Objective-C method. 也就是说，instancetype只能作为返回值，不能像id那样作为参数。
 原来这种技术基本从iOS 5的UINavigationController里就开始应用了。
 
 当一个类返回相同类的实例的时候使用  instancetype 是合适。
 */
- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
                     Delegate:(id<SearchBarViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        _placeHolder = placeHolder;
        
        [self setup:frame];
    }
    return self;
}

- (void)setup:(CGRect)rect
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.8;
    
    // _searchBar
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.backgroundColor=[UIColor clearColor];
    _searchBar.translucent = YES;
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.placeholder = _placeHolder;
    _searchBar.delegate = self;
    for (UIView *view in _searchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            UITextField *textField = [view.subviews objectAtIndex:0];
            textField.returnKeyType = UIReturnKeyDone;
            break;
            
        }
    }
    [self addSubview:_searchBar];
    
    // button
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchButton];
}

- (void)layoutSubviews
{
    //拿出searchBtnImage的大小
    UIImage *image =  _searchBtnImage.length==0?nil:[UIImage imageNamed:_searchBtnImage];
    
    // 设置searchButton大小
    CGFloat searchBtnWidth = image==nil?0:image.size.width;
    CGFloat searchBtnTop = image==nil?margin:(self.bounds.size.height-image.size.height)/2;
    CGFloat searchBtnHeight = image==nil?0:image.size.height;
    searchButton.frame = CGRectMake(self.bounds.size.width-margin-searchBtnWidth, searchBtnTop, searchBtnWidth, searchBtnHeight);
    
    // 设置_searchBar'frame
    _searchBar.frame = CGRectMake(margin, margin, self.bounds.size.width-margin*3-searchBtnWidth, self.bounds.size.height-2*margin);
}

#pragma mark -- setter
- (void)setSearchBtnImage:(NSString *)searchBtnImage
{
    if (_searchBtnImage != searchBtnImage) {
        _searchBtnImage = searchBtnImage;
    }
    
    [searchButton setBackgroundImage:[UIImage imageNamed:_searchBtnImage] forState:UIControlStateNormal];
}

#pragma mark -- setter
- (void)setSearchBtnImagePress:(NSString *)searchBtnImagePress
{
    if (_searchBtnImagePress != searchBtnImagePress) {
        _searchBtnImagePress = searchBtnImagePress;
    }
    
    [searchButton setBackgroundImage:[UIImage imageNamed:_searchBtnImagePress] forState:UIControlStateHighlighted];
}

- (void)setSearchContentKey:(NSString *)searchContentKey
{
    if ([_searchContentKey isEqualToString:searchContentKey]) {
        return;
    }
    _searchContentKey = searchContentKey;
    _searchBar.text = _searchContentKey;
}

#pragma mark -- setter(delegate)
- (void)setDelegate:(id<SearchBarViewDelegate>)delegate
{
    _delegate = delegate;
    
    _delegateFlags.didBeginEdit = [_delegate respondsToSelector:@selector(searchBarFieldDidBeginEditing:)];
    _delegateFlags.didChangeEdit = [_delegate respondsToSelector:@selector(searchBarFieldChangeEditing:)];
    _delegateFlags.didClicked = [_delegate respondsToSelector:@selector(searchBarFieldButtonClicked:)];
    _delegateFlags.didEndEdit = [_delegate respondsToSelector:@selector(searchBarFieldDidEndEditing:)];
}


#pragma mark -- UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    if (_delegateFlags.didChangeEdit) {
        [self.delegate searchBarFieldChangeEditing:searchText];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (_delegateFlags.didBeginEdit) {
        [self.delegate searchBarFieldDidBeginEditing:searchBar];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (_delegateFlags.didEndEdit) {
        [self.delegate searchBarFieldDidEndEditing:searchBar];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if (_delegateFlags.didClicked) {
        [self.delegate searchBarFieldButtonClicked:_searchBar];
    }
}

- (void)searchAction:(UIButton *)button
{
    [_searchBar resignFirstResponder];
    if (_delegateFlags.didClicked) {
        [self.delegate searchBarFieldButtonClicked:_searchBar];
    }
}


@end
