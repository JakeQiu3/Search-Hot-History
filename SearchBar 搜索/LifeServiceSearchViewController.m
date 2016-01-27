//
//  LifeServiceSearchViewController.m
//  VinuxPost
//
//  Created by qsy on 15/12/30.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "LifeServiceSearchViewController.h"
#import "SearchBarView.h"
#import "SearchHistoryView.h"
#import "SearchHistory.h"
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define DefaultColor [UIColor colorWithWhite:0.95 alpha:1.0]
@interface LifeServiceSearchViewController () <UITextFieldDelegate,SearchBarViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;//数据数组
//    BOOL _isSearching;
    NSMutableArray *_searchArray;//搜索内容数组
    NSMutableArray *_historyArray;//输入搜索的历史数组
    UITableView *_tabeleView;
}
@end

@implementation LifeServiceSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultColor;
    _historyArray = @[].mutableCopy;
    SearchBarView *search = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH*2/3, 30) placeHolder:@"输入服务名称" Delegate:self];
    search.layer.masksToBounds =YES;
    search.layer.cornerRadius = 10;
    search.searchBar.returnKeyType = UIReturnKeySearch;
    search.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.navigationItem.titleView = search;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    btn.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = btn;
    
    SearchHistoryView *history = [[SearchHistoryView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:history];
    [self initData];
    [self initSearchData];
    [self creatTable];
}

//加载总数据源
- (void)initData {
    _dataArray = @[@"家电的",@"对方的说法",@"舍得放开舍得放开",@"是",@"都结婚后很快就回家看很"];
}

- (void)initSearchData {
    _searchArray = [[NSMutableArray alloc] init];
    _historyArray = [[SearchHistory shareInstance] getSearchHistoryMArray];
    
}
- (void)creatTable {
    //    创建tableview
    _tabeleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
    _tabeleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tabeleView.hidden = YES;
    _tabeleView.rowHeight = 50;
    _tabeleView.delegate = self;
    _tabeleView.dataSource = self;
    [self.view addSubview:_tabeleView];
}
#pragma mark 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _searchArray[indexPath.row];
    return cell;
}

/**
 搜索框搜索按钮点击事件：点击搜索
 */
- (void)searchBarFieldButtonClicked:(UISearchBar *)searchBar {
    
    [_historyArray addObject:searchBar.text];
    NSLog(@"跳转到新的控制器");
}

/**
 搜索框更新编辑
 */
- (void)searchBarFieldChangeEditing:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {//输入为空
         _tabeleView.hidden = YES;
    } else
        _tabeleView.hidden = NO;
   [self searchDataWithKeyWord:searchText];
}

//搜索的方法：将数据源内搜索的数据加到加载到搜索数组内
- (void)searchDataWithKeyWord:(NSString *)keyWord {
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *tempString = obj;
        if ([tempString containsString:@"舍"]||[tempString containsString:@"家"]||[tempString containsString:@"的"]||[tempString containsString:@"是"]) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            [tempArray  addObject:tempString];
            for (unsigned i = 0 ; i< [tempArray count]; i ++) {
                if ( [_searchArray containsObject:tempArray[i]]==NO) {
                    [_searchArray addObject:tempArray[i]];
                }
            }
        }
    }];
    [_tabeleView reloadData];//刷新表格
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

// 点击搜索的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSLog(@"hhh");
    UITableViewCell *cell;
    cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
   _historyArray = [[SearchHistory shareInstance] getSearchHistoryMArray];
//    [_historyArray addObject:cell.textLabel.text];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_tabeleView endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
