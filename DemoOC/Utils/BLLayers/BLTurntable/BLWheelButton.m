//
//  BLWheelButton.m
//  DemoOC
//
//  Created by bailong on 2021/8/5.
//

#import "BLWheelButton.h"

@implementation BLWheelButton

- (void)setHighlighted:(BOOL)highlighted {
    
}

// 调整 imageview 大小
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat w = 30;
    CGFloat h = 33;
    CGFloat x = (contentRect.size.width-w) * 0.5;
    CGFloat y = 15;
    return CGRectMake(x, y, w, h);
}

// 设置可点区域
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGSize size = self.bounds.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height * 0.5);
    if (CGRectContainsPoint(rect, point)) {
        return [super hitTest:point withEvent:event];
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
