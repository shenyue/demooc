//
//  BLClock.m
//  DemoOC
//
//  Created by bailong on 2021/8/5.
//

#import "BLClock.h"

@interface BLClock ()

{
    NSInteger _ha; // 时针转的角度 /时
    NSInteger _ma; // 分针转的角度 /分
    NSInteger _sa; // 秒针转的角度 /秒
    CALayer *_bgLayer; // 背景
    CALayer *_hLayer; // 时
    CALayer *_mLayer; // 分
    CALayer *_sLayer; // 秒
}

@end

@implementation BLClock

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _ha = 360/12;
        _ma = 360/60;
        _sa = 360/60;
        
        CGSize size = frame.size;
        CGFloat x = size.width * 0.5;
        CGFloat y = size.height * 0.5 - 100.f;
        CALayer *layer = [CALayer layer];
        layer.bounds = CGRectMake(0, 0, 200, 200);
        layer.position = CGPointMake(x, y);
        layer.opacity = 0.3;
        layer.backgroundColor = [UIColor orangeColor].CGColor;
        layer.cornerRadius = 100;
        [self.layer addSublayer:layer];
        _bgLayer = layer;
        
        layer = [CALayer layer];
        layer.bounds = CGRectMake(0, 0, 9, 60);
        layer.position = CGPointMake(x, y);
        layer.anchorPoint = CGPointMake(0.5, 0.95);
        layer.opacity = 0.8;
        layer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:layer];
        _hLayer = layer;
        
        layer = [CALayer layer];
        layer.bounds = CGRectMake(0, 0, 6, 80);
        layer.position = CGPointMake(x, y);
        layer.anchorPoint = CGPointMake(0.5, 0.95);
        layer.opacity = 0.5;
        layer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:layer];
        _mLayer = layer;
        
        layer = [CALayer layer];
        layer.bounds = CGRectMake(0, 0, 3, 100);
        layer.position = CGPointMake(x, y);
        layer.anchorPoint = CGPointMake(0.5, 0.95);
        layer.opacity = 0.8;
        layer.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:layer];
        _sLayer = layer;
        
        [self doRun];
    }
    return self;
}

- (void)doRun {
    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
- (void)timeChange {
    // 获取当前描述
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSInteger h = [cal component:NSCalendarUnitHour fromDate:date];
    NSInteger m = [cal component:NSCalendarUnitMinute fromDate:date];
    NSInteger s = [cal component:NSCalendarUnitSecond fromDate:date];
    // 当前小时数转的角度 + 当前分钟数时针该转的角度 + 当前秒钟数时针该转的角度
    CGFloat ha = [self angleToRadio: h * _ha]
               + [self angleToRadio: m / 60.f * _ha]
               + [self angleToRadio: s / 3600.f * _ha];
    // 当前分钟数分针该转的角度 + 当前秒钟数分针该转的角度
    CGFloat ma = [self angleToRadio: m * _ma]
               + [self angleToRadio: s / 60.f * _ma];
    CGFloat sa = [self angleToRadio: s * _sa];
    _hLayer.transform = CATransform3DMakeRotation(ha, 0, 0, 1);
    _mLayer.transform = CATransform3DMakeRotation(ma, 0, 0, 1);
    _sLayer.transform = CATransform3DMakeRotation(sa, 0, 0, 1);
}
 
- (CGFloat)angleToRadio:(NSInteger)val {
    CGFloat v = val * M_PI / 180.f;
    return v;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
