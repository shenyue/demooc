//
//  BLDraggableView.m
//  DemoOC
//
//  Created by bailong on 2021/7/28.
//

#import "BLDraggableView.h"

@interface BLDraggableView ()

{
    UILabel *_labTag;
}

@end

@implementation BLDraggableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
//    UITouch *touch = [touches anyObject];
//    CGPoint preP = [touch previousLocationInView:self];
//    CGPoint curP = [touch locationInView:self];
//    self.transform = CGAffineTransformTranslate(self.transform, curP.x - preP.x, curP.y - preP.y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
}

- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches {
//    NSLog(@"%s", __func__);
}

- (void)addText {
    if (_labTag == nil) {
        _labTag = [[UILabel alloc] init];
        _labTag.frame = CGRectMake(self.frame.size.width-30.f, 0.f, 30.f, 30.f);
        _labTag.text = [NSString stringWithFormat:@"%ld", self.tag];
        _labTag.textColor = [UIColor purpleColor];
        _labTag.font = [UIFont systemFontOfSize:20];
//        [_labTag sizeToFit];
        [self addSubview:_labTag];
    }
}

// 当事件传递给当前view时调用，调用当前hitTest方法
// 返回最合适的view
// 返回谁，谁就是最合适的view，谁就响应事件，就会调用谁的touch方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"self.tag: %ld", self.tag);
    // 1 判断自己能否接收事件
    // 2 判断是否点在自己身上
    // 3 从后往前遍历子View，把事件传给子控件，调用子控件的hitTest方法
    // 4 如果子控件没有找到最合适的View，那么自己就是最合适的View
    return [super hitTest:point withEvent:event];
}

// 是不是点在自己身上，调用当前View的pointInside:方法
// 在hitTest内部调用
// YES: 点在当前view上，NO: 不在
// point: 当前触摸点，必须要跟方法调用者，在同一个坐标系
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return YES;
//}

@end
