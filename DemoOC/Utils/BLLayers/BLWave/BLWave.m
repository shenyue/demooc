//
//  BLWave.m
//  DemoOC
//
//  Created by bailong on 2021/8/10.
//

#import "BLWave.h"

@interface BLWave () <CAAnimationDelegate>

@end

@implementation BLWave

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setUp {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:touch.view];
    [self addWave:p];
}

- (void)addWave:(CGPoint)point {
    
    // 添加子层
    CGRect frame = CGRectMake(0, 0, 1000.f, 1000.f);
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = frame;
    shape.position = point;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.path = [UIBezierPath bezierPathWithOvalInRect:shape.bounds].CGPath;
    shape.opacity = 0;
    
    // 添加复制层
    CAReplicatorLayer *rLayer = [CAReplicatorLayer layer];
    rLayer.frame = shape.bounds;
    rLayer.instanceCount = 4;
    rLayer.instanceDelay = 0.2;
    [self.layer addSublayer:rLayer];
    [rLayer addSublayer:shape];
    
    // 添加透明动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima1.fromValue = @(0.3);
    anima1.toValue = @(0);
    
    // 添加放大动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    anima2.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)];
    anima2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anima1, anima2];
    group.duration = 2.f;
    group.repeatCount = 2.f;
    group.delegate = self;
    [shape addAnimation:group forKey:@"group"];
    
//    NSLog(@"%ld", self.layer.sublayers.count);
//    NSLog(@"rLayer: %p", rLayer);
//    NSLog(@"shape: %p", shape);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAReplicatorLayer *rLayer = (CAReplicatorLayer *)self.layer.sublayers[0];
//    NSLog(@"rLayer: %p", rLayer);
    for (CAShapeLayer *shape in rLayer.sublayers) {
//        NSLog(@"shape: %p", shape);
        [shape removeFromSuperlayer];
    }
    [rLayer removeFromSuperlayer];
//    NSLog(@"%ld", self.layer.sublayers.count);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
