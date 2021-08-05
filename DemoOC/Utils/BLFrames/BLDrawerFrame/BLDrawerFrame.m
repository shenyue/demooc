//
//  BLDrawerFrame.m
//  DemoOC
//
//  Created by bailong on 2021/7/29.
//

#import "BLDrawerFrame.h"

@interface BLDrawerFrame ()

{
    CGFloat _W;
    UIPanGestureRecognizer *_pan;
    UITapGestureRecognizer *_tap;
}

@end

@implementation BLDrawerFrame

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _W = self.frame.size.width;
        _ratio = 0.8;
        _scale = 1;
        _isScaleWithRatio = NO;
        
        self.clipsToBounds = YES;
                
        UIView *tmpSView = [[UIView alloc] initWithFrame:self.bounds];
        tmpSView.backgroundColor = [UIColor blueColor];
        [self addSubview:tmpSView];
        _vSecondary = tmpSView;
        
        UIView *tmpMView = [[UIView alloc] initWithFrame:self.bounds];
        tmpMView.backgroundColor = [UIColor greenColor];
        [self addSubview:tmpMView];
        _vMain = tmpMView;

        [self addGestureRecognizerForView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)open {
    CGFloat tmpOffset = _W * _ratio;
    [UIView animateWithDuration:0.25f animations:^{
        [self positionWithOffset:tmpOffset];
        CGRect frame = self.vMain.frame;
        frame.origin.x = tmpOffset;
        self.vMain.frame = frame;
    }];
}
- (void)close {
    [UIView animateWithDuration:0.25f animations:^{
        // 清空形变
        self.vMain.transform = CGAffineTransformIdentity;
        // 位置复位
        self.vMain.frame = self.bounds;
    }];
}
- (void)positionWithOffset:(CGFloat)offset {
    // 平移
    CGRect frame = self.vMain.frame;
    frame.origin.x += offset;
    self.vMain.frame = frame;
    if (self.vMain.frame.origin.x <= 0) {
        self.vMain.frame = self.bounds;
    }
    CGFloat tmpOffset = _W * _ratio;
    if (self.vMain.frame.origin.x >= tmpOffset) {
        CGRect frame = self.vMain.frame;
        frame.origin.x = tmpOffset;
        self.vMain.frame = frame;
    }
    
    // 缩放
    // 最大值计算法
    CGFloat r = _isScaleWithRatio ? _ratio : _scale;
    CGFloat s = self.vMain.frame.origin.x * (1 - r) / _W;
    s = 1 - s;
    if (s > 0) {
        self.vMain.transform = CGAffineTransformMakeScale(s, s);
    }
}

- (void)addGestureRecognizerForView {
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.vMain addGestureRecognizer:_pan];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.vSecondary addGestureRecognizer:_tap];
}
- (void)pan:(UIPanGestureRecognizer *)gesture {
    // 获取偏移，相对于原始值
    CGPoint p = [gesture translationInView:self.vMain];
    
    [self positionWithOffset:p.x];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.vMain.frame.origin.x >= _W * 0.5) {
            [self open];
        } else {
            [self close];
        }
    }
    // 清0
    [gesture setTranslation:CGPointZero inView:self.vMain];
}
    
- (void)setRatio:(CGFloat)val {
    // 认为非按比率，表示显示宽度
    if (val > 1) {
        val = val > 20 ? val : 20;
        val = val > _W ? _W : val;
        _ratio = 1 - val / _W;
    // 按比率，表示按自身宽度百分比
    } else {
        val = val > 0.05 ? val : 0.05;
        _ratio = val;
    }
}
- (void)setScale:(CGFloat)val {
    val = val > 0.5 ? val : 0.5;
    val = val > 1 ? 1 : val;
    _scale = val;
}


@end
