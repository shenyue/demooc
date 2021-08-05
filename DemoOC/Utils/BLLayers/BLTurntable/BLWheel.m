//
//  BLWheel.m
//  DemoOC
//
//  Created by bailong on 2021/8/5.
//

#import "BLWheel.h"
 
#import "BLWheelButton.h"

@interface BLWheel () <CAAnimationDelegate>

{
    UIImageView *_vBottom; // 底板
    UIImageView *_vMid; // 中间
    UIButton *_btnBonus; // 抽奖按钮
    BLWheelButton * _preBtn; // 上一个按钮
}

@end

@implementation BLWheel

@synthesize vBottom = _vBottom;
@synthesize vMid = _vMid;
@synthesize btnBonus = _btnBonus;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGSize size = frame.size;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.bounds];
        iv.backgroundColor = [UIColor redColor];
        iv.alpha = 0.5;
        [self addSubview:iv];
        _vBottom = iv;
        
        iv = [[UIImageView alloc] initWithFrame:self.bounds];
        iv.backgroundColor = [UIColor orangeColor];
        iv.alpha = 0.5;
        [self addSubview:iv];
        _vMid = iv;
        
        CGFloat w = 80.f;
        CGFloat h = 80.f;
        CGRect frame = CGRectMake((size.width-w)*0.5, (size.height-h)*0.5, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitle:@"抽奖" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getBonus:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _btnBonus = btn;
        
        [self setUp];
    }
    return self;
}
- (void)getBonus:(UIButton *)btn {
    
    
    
    // 让转盘快速旋转
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.rotation";
    anima.toValue = @(M_PI * 4);
    anima.repeatCount = 1;
    anima.duration = 1.f;
    anima.delegate = self;
    [_vMid.layer addAnimation:anima forKey:nil];
    // 停止动画时，选中指向最上方
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CGAffineTransform tranform = _preBtn.transform;
    CGFloat angle = atan2(tranform.b, tranform.a);
    _vMid.transform = CGAffineTransformMakeRotation(-angle);
}

- (void)setUp {
    _vMid.userInteractionEnabled = YES;
    CGFloat angle = 0;
    int cnt = 12;
    UIImage *img = [UIImage imageNamed:@"sp"];
    CGFloat sscale = [UIScreen mainScreen].scale;
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat w = 40.f * sscale;
    CGFloat h = 45.f * sscale;
    for (int i=0; i<cnt; i++) {
        BLWheelButton *btn = [BLWheelButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.backgroundColor = [UIColor greenColor];
        if (i % 2 == 0) {
            btn.alpha = 0.8;
        } else {
            btn.alpha = 0.5;
        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_vMid addSubview:btn];
        
        x = w * (i % 5);
        y = h * (i / 5);
        CGRect rect = CGRectMake(x, y, w, h);
        // 此方法是 C 方法, rect是像素 需要乘以 scale
        CGImageRef imgRef = CGImageCreateWithImageInRect(img.CGImage, rect);
        UIImage *img = [UIImage imageWithCGImage:imgRef];
        [btn setImage:img forState:UIControlStateNormal];
        btn.bounds = CGRectMake(0, 0, 68.f, 148.f);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(_vMid.bounds.size.width*0.5, _vMid.bounds.size.height*0.5);
        btn.transform = CGAffineTransformMakeRotation(angle * M_PI / 180.f);
        angle += (360/cnt);
        if (i == 0) {
            [self click:btn];
        }
    }
}
- (void)click:(BLWheelButton *)btn {
    if (_preBtn) {
        _preBtn.selected = NO;
        _preBtn.backgroundColor = [UIColor greenColor];
    }
    btn.selected = YES;
    btn.backgroundColor = [UIColor redColor];
    _preBtn = btn;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
