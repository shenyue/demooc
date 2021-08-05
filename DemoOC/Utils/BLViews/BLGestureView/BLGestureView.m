//
//  BLGestureView.m
//  DemoOC
//
//  Created by bailong on 2021/7/29.
//

#import "BLGestureView.h"

@interface BLGestureView ()<UIGestureRecognizerDelegate>

{
    UITapGestureRecognizer *_tap;
    UISwipeGestureRecognizer *_swipe;
    UILongPressGestureRecognizer *_longPress;
    UIPanGestureRecognizer *_pan;
    UIRotationGestureRecognizer *_rotation;
    UIPinchGestureRecognizer *_pinch;
}

@end

@implementation BLGestureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


#pragma mark Delegate
- (void)addGestureDelegate {
    _tap.delegate = self;
}


#pragma mark Tap
- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:gesture];
    _tap = gesture;
}
- (void)tap:(UITapGestureRecognizer *)gesture {
    NSLog(@"%s", __func__);
}


#pragma mark Swipe
- (void)addSwipeGestureRecognizer {
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self addGestureRecognizer:gesture];
    // 这样写是区分不出方向的，一个手势仅支持一个方向，支持多个方向必须写多个手势
//    gesture.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    gesture.direction = UISwipeGestureRecognizerDirectionLeft;
    _swipe = gesture;
}
- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    NSLog(@"%s", __func__);
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"left");
    } else if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
    }
}

#pragma mark LongPress
- (void)addLongPressGestureRecognizer {
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:gesture];
    _longPress = gesture;
}
- (void)longPress:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"%s", __func__);
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"began");
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"changed");
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"ended");
    }
}

#pragma mark Pan
- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:gesture];
    _pan = gesture;
}
- (void)pan:(UIPanGestureRecognizer *)gesture {
    NSLog(@"%s", __func__);
    // translationInView 计算出的偏移量 是相对原始点
    CGPoint p = [gesture translationInView:self];
    NSLog(@"%@", NSStringFromCGPoint(p));
    // 此处这样设置会出现一个问题，就是第二次拖动时，该视图又蹦回到原点开始计算
//    self.transform = CGAffineTransformMakeTranslation(p.x, p.y);
    // 但是此处也不能这样直接设置，因为偏移的累加
    self.transform = CGAffineTransformTranslate(self.transform, p.x, p.y);
    // 清0
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
}

#pragma mark Rotation
- (void)addRotationGestureRecognizer {
    UIRotationGestureRecognizer *gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self addGestureRecognizer:gesture];
    _rotation = gesture;
}
- (void)rotation:(UIRotationGestureRecognizer *)gesture {
    NSLog(@"%s", __func__);
    // translationInView 计算出的偏移量 是相对原始点
    CGFloat v = gesture.rotation;
    self.transform = CGAffineTransformRotate(self.transform, v);
    // 清0
    [gesture setRotation:0];
}

#pragma mark Pinch
- (void)addPinchGestureRecognizer {
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self addGestureRecognizer:gesture];
    _pinch = gesture;
}
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    NSLog(@"%s", __func__);
    // translationInView 计算出的偏移量 是相对原始点
    CGFloat v = gesture.scale;
    self.transform = CGAffineTransformScale(self.transform, v, v);
    // 清0
    [gesture setScale:1];
}






#pragma mark GestureRecognizerDelegate Function
// 是否接收手指
// 如果判断某试图点击某部分是否响应手势，再此方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint p = [touch locationInView:self];
    if (p.y > self.bounds.size.height/2.f) {
        return YES;
    }
    return NO;
}
// 是否支持多个手势同时执行
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
