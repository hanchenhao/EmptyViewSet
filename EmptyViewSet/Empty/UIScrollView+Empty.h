//
//  UIScrollView+Empty.h
//  EmptyTableview
//
//  Created by 韩陈昊 on 2017/2/9.
//  Copyright © 2017年 韩陈昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmptyDelegate <NSObject>

@optional
- (void) buttonTouchHandle;

@end


@interface UIScrollView (Empty)

@property (nonatomic , weak) id<EmptyDelegate> emptyDelegate;

//  显示EmptyView(手动控制)
- (void) showEnptyView;

//  隐藏EmptyView(手动控制)
- (void) hidenEmptyView;

//  检测是否内容并自动显示及隐藏EmptyView
- (void) checkTableViewSectionCount;
@end
