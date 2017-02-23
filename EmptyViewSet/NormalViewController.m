//
//  NormalViewController.m
//  EmptyView
//
//  Created by 韩陈昊 on 2017/2/20.
//  Copyright © 2017年 韩陈昊. All rights reserved.
//

#import "NormalViewController.h"
#import "UIScrollView+Empty.h"

@interface NormalViewController ()<EmptyDelegate , UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *normalTableView;
@property (nonatomic , strong) NSMutableArray<NSString *> *mArray;

@end

@implementation NormalViewController

- (NSMutableArray *)mArray{
    if (_mArray == nil) {
        _mArray = [NSMutableArray array];
        [_mArray addObject:@"清除数据"];
        
    }
    return _mArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.normalTableView.tableFooterView = [UIView new];
    self.normalTableView.emptyDelegate = self;

}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.mArray.count > 0 ? [self.normalTableView hidenEmptyView] : [self.normalTableView showEnptyView];
    
    return self.mArray.count;
    
}

- (void)buttonTouchHandle {
    for (int i = 0; i < 10 ; i++) {
        if (i == 0) {
            [self.mArray addObject:[NSString stringWithFormat:@"清除数据"]];
            continue;
        }
        [self.mArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.normalTableView reloadData];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
    cell.textLabel.text = self.mArray[indexPath.row];
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) return;
    
    [self.mArray removeAllObjects];
    [self.normalTableView reloadData];
    
}
@end
