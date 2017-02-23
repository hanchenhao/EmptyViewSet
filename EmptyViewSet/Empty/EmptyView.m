//
//  UIScrollView+Empty.h
//  EmptyTableview
//
//  Created by 韩陈昊 on 2017/2/9.
//  Copyright © 2017年 韩陈昊. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (IBAction)buttonDIdTouch:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidClicked)]) {
        [self.delegate buttonDidClicked];
    }
}

@end
