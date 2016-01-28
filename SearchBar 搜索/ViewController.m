//
//  ViewController.m
//  SearchBar 搜索
//
//  Created by 邱少依 on 15/12/31.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "ViewController.h"
#import "MainSearchViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 150, 30);
    btn.center = self.view.center;
    [btn setTitle: @"搜索" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    [btn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)push:(UIButton *)btn {
    MainSearchViewController *lifeVC = [[MainSearchViewController alloc] init];
    [self.navigationController pushViewController:lifeVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
