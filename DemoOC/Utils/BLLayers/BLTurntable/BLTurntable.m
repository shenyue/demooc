//
//  BLTurntable.m
//  DemoOC
//
//  Created by bailong on 2021/8/5.
//

#import "BLTurntable.h"

#import "BLWheel.h"

@interface BLTurntable ()

{
    UIButton *_btnStart; // 开始
    UIButton *_btnStop; // 停止
    BLWheel *_vWheel; //
}

@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation BLTurntable

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat w = 100.f;
        CGFloat h = 40.f;
        CGRect f = CGRectMake(30.f, 100.f, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:f];
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitle:@"开始" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _btnStart = btn;
        
        f = CGRectMake(230.f, 100.f, w, h);
        btn = [[UIButton alloc] initWithFrame:f];
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitle:@"停止" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _btnStop = btn;
        
        w = 300.f;
        h = 300.f;
        f = CGRectMake((frame.size.width-w)*0.5, (frame.size.height-h)*0.5, w, h);
        BLWheel *view = [[BLWheel alloc] initWithFrame:f];
        [self addSubview:view];
        _vWheel = view;
        
    }
    return self;
}

- (CADisplayLink *)link {
    if (_link == nil) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
    }
    return _link;
}
- (void)start:(UIButton *)btn {
    self.link.paused = NO;
        
//    CABasicAnimation *anima = [CABasicAnimation animation];
//    anima.keyPath = @"transform.rotation";
//    anima.toValue = @(M_PI * 2);
//    anima.duration = 3.f;
//    anima.repeatCount = HUGE;
//    [_vWheel.vMid.layer addAnimation:anima forKey:nil];
}
- (void)update {
    _vWheel.vMid.transform = CGAffineTransformRotate(_vWheel.vMid.transform, M_PI/300.f);
}


- (void)stop:(UIButton *)btn {
    self.link.paused = YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
