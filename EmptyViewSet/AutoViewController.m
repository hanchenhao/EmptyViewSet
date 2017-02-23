//
//  AutoViewController.m
//  EmptyView
//
//  Created by 韩陈昊 on 2017/2/20.
//  Copyright © 2017年 韩陈昊. All rights reserved.
//

#import "AutoViewController.h"
#import "UIScrollView+Empty.h"
#import "MJRefresh.h"
@interface AutoViewController ()<EmptyDelegate>

@property (nonatomic , strong) NSMutableArray<NSString *> *mArray;
@property (weak, nonatomic) IBOutlet UITableView *autoTable;

@end

@implementation AutoViewController
- (NSMutableArray *)mArray{
    if (_mArray == nil) {
        _mArray = [NSMutableArray array];

    }
    return _mArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.autoTable.emptyDelegate = self;
    self.autoTable.tableFooterView = [UIView new];
    self.autoTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
}

- (void) refresh {
    for (int i = 0; i < 10 ; i++) {
        [self.mArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.autoTable reloadData];
    [self.autoTable.mj_header endRefreshing];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mArray.count;
    
}

- (void)buttonTouchHandle {
    [self.autoTable.mj_header beginRefreshing];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"auto"];
    cell.textLabel.text = self.mArray[indexPath.row];
    [self.autoTable checkTableViewSectionCount];
    return cell;
}

@end
