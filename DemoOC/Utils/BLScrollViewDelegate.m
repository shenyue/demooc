//
//  BLScrollViewDelegate.m
//  DemoOC
//
//  Created by bailong on 2021/7/17.
//

#import "BLScrollViewDelegate.h"

@interface BLScrollViewDelegate()

@end

@implementation BLScrollViewDelegate

// 用户即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
}
// 用户即将停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"scrollViewWillEndDragging");
}
// 用户已经停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
    // 已停止滚动
    if (decelerate == NO) {
        
    }
}
// 正在滚动的时候监听此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView scrolling");
}
// 减速完毕，已经停止滚动，
// 有时可能不会调用，因为手指松开那一刻已经停止了
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}


@end
