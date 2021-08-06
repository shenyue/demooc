//
//  BLReplicator.m
//  DemoOC
//
//  Created by bailong on 2021/8/6.
//

#import "BLReplicator.h"

@interface BLReplicator ()

@end

@implementation BLReplicator

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
        
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(20, 100, 50, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.scale";
    anima.toValue = @(0.5);
    anima.autoreverses = YES;
    anima.repeatCount = HUGE;
    anima.duration = 0.5;
    [layer addAnimation:anima forKey:nil];
        
    CAReplicatorLayer *rLayer = [CAReplicatorLayer layer];
    [self.layer addSublayer:rLayer];
    rLayer.frame = self.bounds;
    rLayer.backgroundColor = [UIColor blueColor].CGColor;
    rLayer.instanceCount = 6;
    rLayer.instanceDelay = 0.2;
    rLayer.instanceTransform = CATransform3DMakeTranslation(60, 0, 0);
    [rLayer addSublayer:layer];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
