//
//  UIScrollView+Empty.h
//  EmptyTableview
//
//  Created by 韩陈昊 on 2017/2/9.
//  Copyright © 2017年 韩陈昊. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol EmptyViewDelegate <NSObject>

@optional
- (void) buttonDidClicked;

@end

@interface EmptyView : UIView

@property (nonatomic , weak) id<EmptyViewDelegate> delegate;

@end
