//
//  UIScrollView+Empty.h
//  EmptyTableview
//
//  Created by 韩陈昊 on 2017/2/9.
//  Copyright © 2017年 韩陈昊. All rights reserved.
//

#import "UIScrollView+Empty.h"
#import <objc/runtime.h>
#import "EmptyView.h"

@interface  UIScrollView ()<EmptyViewDelegate>


@end

@implementation UIScrollView (Empty)

static char emptyKey;
static char emptyViewKey;

#pragma mark -setter and getter

- (UIView *)emptyDelegate {
    return objc_getAssociatedObject(self, &emptyKey);
    
}

- (void)setEmptyDelegate:(id<EmptyViewDelegate>)emptyDelegate {
    objc_setAssociatedObject(self, &emptyKey, emptyDelegate, OBJC_ASSOCIATION_ASSIGN);
}


- (EmptyView *)emptyView {
    EmptyView *empty =objc_getAssociatedObject(self, &emptyViewKey);
    if (!empty) {
        empty = [[[NSBundle mainBundle] loadNibNamed:@"EmptyView" owner:self options:nil] firstObject];
        empty.delegate =  self;
        empty.frame = self.bounds;
        [self setNeedsLayout];
        [self setEmptyView:empty];
    }
    return empty;
}

- (void)setEmptyView:(EmptyView *)emptyView {
    objc_setAssociatedObject(self, &emptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (void)load {
    [self swizzleSelector:@selector(awakeFromNib) withSelector:@selector(ch_awakeFromNib)];
    
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void) ch_awakeFromNib {
    [self ch_awakeFromNib];
    [self checkTableViewSectionCount];
    
}

- (void) checkTableViewSectionCount {
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        NSInteger conuts = 0;
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                conuts += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }

        conuts == 0 ? [self showEnptyView] : [self hidenEmptyView];
    }
}
- (void) showEnptyView {
    [self addSubview:self.emptyView];
    
}

- (void) hidenEmptyView {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[EmptyView class]]) {
            [obj removeFromSuperview];
        }
    }];
    
}


- (void) buttonDidClicked {
    
    if (self.emptyDelegate && [self.emptyDelegate respondsToSelector:@selector(buttonTouchHandle)]) {
        [self.emptyDelegate buttonTouchHandle];
    }

}



@end
