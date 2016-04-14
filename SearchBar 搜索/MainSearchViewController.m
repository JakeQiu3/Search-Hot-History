//
//  LifeServiceSearchViewController.m
//  VinuxPost
//
//  Created by qsy on 15/12/30.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "MainSearchViewController.h"
#import "SeaSaleSearchBarView.h"
#import "SearchHistoryAndHotView.h"
#import "SearchHistoryModel.h"
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define DefaultColor [UIColor colorWithWhite:0.95 alpha:1.0]
static NSString *const cellIdentifier = @"cellIdentifierKey";

@interface MainSearchViewController () <UITextFieldDelegate,SearchBarViewDelegate,UITableViewDataSource,UITableViewDelegate,SearchItemDelegate>
{
    NSArray *_dataArray;//总的数据数组
    NSMutableArray *_searchArray;//输入搜索关键字检索得到的内容数组，在dataArray
    NSMutableArray *_historyArray;//历史数组
    UITableView *_tabeleView;
}

@end

@implementation MainSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultColor;
    [self initData];//初始化数据
    [self initNavigationBarSearchBar];//初始化导航条内容
    [self addSearchContentView];//添加搜索内容（热门和历史）视图
    [self creatTable];//创建搜索历史的tableview
    
}
//加载数据源
- (void)initData {
//    总的数据源，检索库
    _dataArray = @[@"家电",@"说法",@"我就是我",@"是的",@"颜色不一样的烟花",@"我的生活没有自然和社会"];
    _searchArray = [[NSMutableArray alloc] init];
    _historyArray = [[SearchHistoryModel shareInstance] getSearchHistoryMArray];
}

- (void)initNavigationBarSearchBar {
    SeaSaleSearchBarView *search = [[SeaSaleSearchBarView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH*2/3, 30) placeHolder:@"输入服务名称" Delegate:self];
    search.layer.masksToBounds =YES;
    search.layer.cornerRadius = 10;
    search.searchBar.returnKeyType = UIReturnKeySearch;
    search.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.navigationItem.titleView = search;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    btn.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)popVC {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addSearchContentView {
    SearchHistoryAndHotView *historyAndHotView = [[SearchHistoryAndHotView alloc]initWithFrame:self.view.bounds];
    historyAndHotView.searchHotAndHistoryDelegate = self;
    [self.view addSubview:historyAndHotView];

}

- (void)creatTable {
    //    创建tableview
    _tabeleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
    _tabeleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tabeleView.hidden = YES;
    _tabeleView.rowHeight = 50;
    _tabeleView.delegate = self;
    _tabeleView.dataSource = self;
    [_tabeleView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tabeleView];
}
#pragma mark   tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _searchArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"选择数据库中哪个关键字对应的搜索词进行搜索： %@",cell.textLabel.text);
//    加入进历史搜索数组中
    _historyArray = [[SearchHistoryModel shareInstance] getSearchHistoryMArray];
    if (![_historyArray containsObject:cell.textLabel.text]) {//判断是否包含该字段
         [_historyArray addObject:cell.textLabel.text];
    }
}

#pragma  mark 搜索的代理方法
/**
 搜索框搜索按钮点击事件：点击搜索
 */
- (void)searchBarFieldButtonClicked:(UISearchBar *)searchBar {
    _historyArray = [[SearchHistoryModel shareInstance] getSearchHistoryMArray];
    if (![_historyArray containsObject:searchBar.text]) {
         [_historyArray addObject:searchBar.text];
    }
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
        if ([tempString containsString:keyWord]||[tempString containsString:@"我"]) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            [tempArray  addObject:tempString];
            for (unsigned i = 0 ; i< [tempArray count]; ++i) {
                if (![_searchArray containsObject:tempArray[i]]) {
                    [_searchArray addObject:tempArray[i]];
                }
            }
        }
    }];
    [_tabeleView reloadData];//刷新表格
}

#pragma  mark 少 热门和历史搜索的Delegate方法

- (void)searchItemClickHotItem:(NSString *)itemName collectionItem:(ClickCollectionItem)collectionItem {
    if (collectionItem == ClickCollectionItemHot) {//若点击的是热门
         NSLog(@"点击热门:%@",itemName);
       
    } else {//搜索历史记录
         NSLog(@"点击搜索历史:%@",itemName);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_tabeleView endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
