//
//  BLCoverFrame.m
//  DemoOC
//
//  Created by bailong on 2021/8/13.
//

#import "BLCoverFrame.h"

@interface BLCoverFrame ()

{
    BLCoverFramePopupDirection _defaultDirection;
    
    CGFloat _W;
    CGFloat _H;
    CGPoint _oriCenter;

    UIView *_vCover; // 背景view
    UIView *_vContainer; // 容器view
}

@end

@implementation BLCoverFrame

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}
- (void)setUp {
    CGRect bounds = [UIScreen mainScreen].bounds;
    _W = bounds.size.width;
    _H = bounds.size.height;
    self.toCoverAlpha = 0.5;
    self.duration = 0.25;
    self.diraction = BLCoverFramePopupDirectionFromBottom;
    self.coverColor = [UIColor blackColor];
    self.offsetX = 0.f;
    self.offsetY = 0.f;
    
    self.frame = bounds;
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 1.f;
    
    // 创建 背景view
    UIView *cover = [[UIView alloc] init];
    cover.frame = bounds;
    cover.backgroundColor = self.coverColor;
    cover.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    [cover addGestureRecognizer:tap];
    [self addSubview:cover];
    _vCover = cover;
    
    // 创建 容器视图
    UIView *container = [[UIView alloc] init];
    [self addSubview:container];
    _vContainer = container;
}
- (void)close:(UITapGestureRecognizer *)gesture {
    [self closeView];
}
- (void)closeView {
    if (self.diraction == BLCoverFramePopupDirectionFromCenter) {
        [self animaScaleOut];
        [UIView animateWithDuration:self.duration animations:^{
            self->_vCover.alpha = 0.f;
            self->_vContainer.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if ([self.delegate respondsToSelector:@selector(closeBLCoverFrame:)]) {
                [self.delegate closeBLCoverFrame:self];
            }
        }];
    } else if (self.diraction == BLCoverFramePopupDirectionFromCustomToCenter) {
        
    } else {
        [UIView animateWithDuration:self.duration animations:^{
            self->_vCover.alpha = 0.f;
            self->_vContainer.center = self->_oriCenter;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if ([self.delegate respondsToSelector:@selector(closeBLCoverFrame:)]) {
                [self.delegate closeBLCoverFrame:self];
            }
        }];
    }
}






- (void)addSelfForKeywindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
- (void)showWithView:(UIView *)view {
    if (self.diraction == BLCoverFramePopupDirectionFromCenter) {
        NSLog(@"请使用 - (void)showDirectionFromCenterWithView:(UIView *)view toRect:(CGRect)toRect; 或者 - (void)showDirectionFromCenterWithView:(UIView *)view toRect:(CGRect)toRect backgroundColor:(UIColor *)color alpha:(CGFloat)alpha duration:(NSTimeInterval)duration;");
        return;
    } else if (self.diraction == BLCoverFramePopupDirectionFromCustomToCenter) {
        NSLog(@"请使用 - (void)showDirectionFromCustomToCenterWithView:(UIView *)view fromRect:(CGRect)fromRect toRect:(CGRect)toRect; 或者 - (void)showDirectionFromCustomToCenterWithView:(UIView *)view fromRect:(CGRect)fromRect toRect:(CGRect)toRect backgroundColor:(UIColor *)color alpha:(CGFloat)alpha duration:(NSTimeInterval)duration;");
        return;
    }
    
    [self addSelfForKeywindow];
    if (view) {
        [_vContainer addSubview:view];
    }
    _vCover.backgroundColor = self.coverColor;
    
    // 计算位置
    CGFloat x=0.f, y=0.f, w=0.f, h=0.f, cx=0.f, cy=0.f;
    if (self.diraction == BLCoverFramePopupDirectionFromBottom
        || self.diraction == BLCoverFramePopupDirectionFromTop) {
        w = _W;
        h = view.bounds.size.height;
        cx = w * 0.5;
        if (self.diraction == BLCoverFramePopupDirectionFromBottom) {
            y = _H + h;
            cy = _H - h * 0.5;
        } else {
            y = -h;
            cy = h * 0.5;
        }
    } else if (self.diraction == BLCoverFramePopupDirectionFromLeft
               || self.diraction == BLCoverFramePopupDirectionFromRight) {
        h = _H;
        w = view.bounds.size.width;
        if (self.diraction == BLCoverFramePopupDirectionFromLeft) {
            x = -w;
            cx = w * 0.5;
        } else {
            x = _W + w;
            cx = _W - w * 0.5;
        }
    }
    CGRect tmpRect = CGRectMake(x, y, w, h);
    _vContainer.frame = tmpRect;
    _oriCenter = _vContainer.center;
    CGPoint tmpToCenter;
    if (self.diraction == BLCoverFramePopupDirectionFromBottom
        || self.diraction == BLCoverFramePopupDirectionFromTop) {
        tmpToCenter = CGPointMake(_oriCenter.x, cy);
    } else {
        tmpToCenter = CGPointMake(cx, _oriCenter.y);
    }

    // 动画展示
    [UIView animateWithDuration:self.duration animations:^{
        self->_vCover.alpha = self.toCoverAlpha;
        self->_vContainer.center = tmpToCenter;
    } completion:nil];
    
//    NSLog(@"tmpRect: %@", NSStringFromCGRect(tmpRect));
//    NSLog(@"tmpToCenter: %@", NSStringFromCGPoint(tmpToCenter));
//    NSLog(@"self: %p", self);
//    NSLog(@"_vCover: %p", _vCover);
//    NSLog(@"_vContainer: %p", _vContainer);
//    NSLog(@"view: %p", view);
//    NSLog(@"self count: %ld", self.subviews.count);
//    NSLog(@"_vContainer count: %ld", _vContainer.subviews.count);
}

- (void)showDirectionFromCenterWithView:(UIView *)view {
    if (view == nil) {
        NSLog(@"请设置 view");
        return;
    }
    
    self.diraction = BLCoverFramePopupDirectionFromCenter;
    [self addSelfForKeywindow];
    if (view) {
        [_vContainer addSubview:view];
    }
    _vCover.backgroundColor = self.coverColor;
    
    CGFloat vw = view.frame.size.width;
    CGFloat vh = view.frame.size.height;
    CGFloat r = vw / vh;
    // 如果 r > 1, 当 w > _W, w = _W即可;
    CGFloat tw = 0.f;
    CGFloat th = 0.f;
    if (r > 1) {
        if (vw > _W) {
            tw = _W;
            th = tw / r;
        } else {
            tw = vw;
            th = vh;
        }
    } else {
        if (vh > _H) {
            th = _H;
            tw = th / r;
        } else {
            tw = vw;
            th = vh;
        }
    }
    CGFloat x = (_W - tw) * 0.5 + self.offsetX;
    CGFloat y = (_H - th) * 0.5 + self.offsetY;
    CGFloat w = tw;
    CGFloat h = th;
    _vContainer.frame = CGRectMake(x, y, w, h);
    _vContainer.alpha = 0.f;

    // 添加动画
    [self animaScaleIn];
    [UIView animateWithDuration:self.duration animations:^{
        self->_vCover.alpha = self.toCoverAlpha;
        self->_vContainer.alpha = 1.f;
    } completion:nil];
    
    NSLog(@"%@", NSStringFromCGRect(view.frame));
    NSLog(@"%@", NSStringFromCGRect(_vContainer.frame));
    NSLog(@"self: %p", self);
    NSLog(@"_vCover: %p", _vCover);
    NSLog(@"_vContainer: %p", _vContainer);
    NSLog(@"view: %p", view);
    NSLog(@"self count: %ld", self.subviews.count);
    NSLog(@"_vContainer count: %ld", _vContainer.subviews.count);
    NSLog(@"");
    NSLog(@"");
}
- (void)animaScaleFromValue:(CGFloat)fromVale toValue:(CGFloat)toValue {
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.scale";
    anima.fromValue = @(fromVale);
    anima.toValue = @(toValue);
//    anima.fillMode = kCAFillModeForwards;
//    anima.removedOnCompletion = NO;
    [_vContainer.layer addAnimation:anima forKey:@"scale"];
}
- (void)animaScaleIn {
    [self animaScaleFromValue:0.f toValue:1.f];
}
- (void)animaScaleOut {
    [self animaScaleFromValue:1.f toValue:0.f];
}



- (void)showDirectionFromCustomToCenterWithView:(UIView *)view {

}



#pragma mark Setter & Getter
- (void)setDuration:(NSTimeInterval)duration {
    if (_duration < 0.f || _duration > 2.f) {
        _duration = 0.25;
        return;
    }
    _duration = duration;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
