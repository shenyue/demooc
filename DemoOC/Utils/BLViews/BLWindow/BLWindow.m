//
//  BLWindow.m
//  DemoOC
//
//  Created by bailong on 2021/7/28.
//

#import "BLWindow.h"

@implementation BLWindow

// 1 用户点击屏幕产生一个触摸事件，经过一系列的传递找到最合适的试图来处理这个事件
// 1) 判断自己能否接收事件
// 2) 判断是否点在自己身上
// 3) 从后往前遍历子View，把事件传给子控件，调用子控件的hitTest方法
// 4) 如果子控件没有找到最合适的View，那么自己就是最合适的View
// 5) 父控件是否能接收事件
// 6) 是否超出了父控件的大小,(通过设置背景颜色查看是否超出父控件)当一个控件超出父控件的大小，正常是不能接收事件的

// 2 touchesBegan方法的默认做法是将事件顺着响应者链条向上传递，将事件交给上一个响应者处理

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 1 判断自己能否接收事件
    if (self.userInteractionEnabled == NO
        || self.hidden == YES
        || self.alpha <= 0.01) {
        return nil;
    }
    // 2 判断是否点在自己身上
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    // 3 从后往前遍历子View，把事件传给子控件，调用子控件的hitTest方法
    int count = (int)self.subviews.count;
    for (int i=count-1; i>=0; i--) {
        UIView *childView = self.subviews[i];
        // 把当前点坐标系转换成子控件的坐标系
        CGPoint childPoint = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childPoint withEvent:event];
        if (fitView) {
            return fitView;
        }
    }
    // 4 如果子控件没有找到最合适的View，那么自己就是最合适的View
    return self;
}


@end
