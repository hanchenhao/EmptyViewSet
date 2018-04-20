//
//  CollectionViewController.m
//  EmptyViewSet
//
//  Created by 韩陈昊 on 2018/4/20.
//  Copyright © 2018年 韩陈昊. All rights reserved.
//

#import "CollectionViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+Empty.h"
@interface CollectionViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , EmptyDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray<NSString *> *mArray;

@end

@implementation CollectionViewController

- (NSMutableArray *)mArray{
    if (_mArray == nil) {
        _mArray = [NSMutableArray array];
    }
    return _mArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.emptyDelegate = self;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];

}


- (void) refresh {
    for (int i = 0; i < 10 ; i++) {
        [self.mArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
}

- (void)buttonTouchHandle {
    [self.collectionView.mj_header beginRefreshing];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.mArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    [self.collectionView checkTableViewSectionCount];

    return  cell;
}




@end
