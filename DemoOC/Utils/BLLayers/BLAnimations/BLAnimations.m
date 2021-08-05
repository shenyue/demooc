//
//  BLAnimations.m
//  DemoOC
//
//  Created by bailong on 2021/8/5.
//

#import "BLAnimations.h"

@interface BLAnimations ()

{
    CALayer *_aLayer; //
    CAShapeLayer *_asLayer; //
    CGPoint _prePoint; // 上次起点
    UIBezierPath *_path;
}

@end

@implementation BLAnimations

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGSize size = frame.size;
        CGFloat x = size.width * 0.5;
        CGFloat y = size.height * 0.5 - 200.f;
        CALayer *layer = [CALayer layer];
        layer.bounds = CGRectMake(0, 0, 200, 200);
        layer.position = CGPointMake(x, y);
//        layer.opacity = 0.5;
        layer.backgroundColor = [UIColor orangeColor].CGColor;
//        layer.cornerRadius = 10;
        [self.layer addSublayer:layer];
        _aLayer = layer;
        
        
        // 三角形
        // 水平向右为正方向绘制
        // 这样 anima.rotationMode = kCAAnimationRotateAuto; 的方向才正确
        UIBezierPath *trianglePath = [UIBezierPath bezierPath];
        [trianglePath moveToPoint:CGPointMake(30, 5)];
        [trianglePath addLineToPoint:CGPointMake(0, 0)];
        [trianglePath addLineToPoint:CGPointMake(0, 10)];
        [trianglePath closePath];
         
        CAShapeLayer *slayer = [CAShapeLayer layer];
        slayer.bounds = CGRectMake(0, 0, 30, 10);
        slayer.path = trianglePath.CGPath;
        slayer.fillColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:slayer];
        _asLayer = slayer;
        
        _prePoint = slayer.position;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:touch.view];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_prePoint];
    [path addLineToPoint:curP];
    _prePoint = curP;
    _path = path;
//    [self addCABasicAnimation];
//    [self addCABasicAnimation_heartbeat];
//    [self addCAKeyframeAnimation_jiggle];
//    [self addCAKeyframeAnimation_move];
//    [self addCATransition];
    [self addCAAnimationGroup];
}

#pragma mark CABasicAnimation
- (void)addCABasicAnimation {
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"position.y";
    anima.toValue = @(400);
    // 动画结束后是否移除动画
    anima.removedOnCompletion = NO;
    // 动画完成时保持什么状态
    anima.fillMode = kCAFillModeForwards;
    // kCAFillModeForwards
    // kCAFillModeBackwards
    // kCAFillModeBoth
    // kCAFillModeRemoved
    
    [_aLayer addAnimation:anima forKey:@"new"];
}
- (void)addCABasicAnimation_heartbeat {
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.scale";
    anima.toValue = @(0);
    anima.repeatCount = HUGE;
    anima.duration = 0.5f;
    // 自动反转
    anima.autoreverses = YES;
    [_aLayer addAnimation:anima forKey:@"new"];
}


#pragma mark CAKeyframeAnimation
#define angleToRadio(angle) ((angle) * M_PI / 180.0)
// 抖动模式
- (void)addCAKeyframeAnimation_jiggle {
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animation];
    anima.keyPath = @"transform.rotation";
    anima.values = @[@(angleToRadio(-5)), @(angleToRadio(5))];
    anima.repeatCount = HUGE;
    anima.duration = 0.12f;
    anima.autoreverses = YES;
    [_aLayer addAnimation:anima forKey:@"new"];
}

- (void)addCAKeyframeAnimation_move {
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animation];
    anima.keyPath = @"position";
    anima.path = _path.CGPath;
    anima.duration = 1.f;
    anima.rotationMode = kCAAnimationRotateAuto;
    // kCAAnimationRotateAuto
    // kCAAnimationRotateAutoReverse
    anima.calculationMode = kCAAnimationCubicPaced;
    // kCAAnimationLinear
    // kCAAnimationDiscrete
    // kCAAnimationPaced
    // kCAAnimationCubic
    // kCAAnimationCubicPaced
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [_asLayer addAnimation:anima forKey:@"new"];
}


#pragma mark CATranslation
- (void)addCATransition {
    // 转场代码 和 转场动画必须在同一个方法中
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";
    // kCATransitionFade // 淡出淡入
    // kCATransitionMoveIn // 入场
    // kCATransitionPush // 推
    // kCATransitionReveal // 出场
    // @"cube" // 魔方反转
    // @"oglFlip" // 中轴反转
    // @"pageCurl" // 翻页
    // @"pageUnCurl" // 回翻页
    // 以下不好用
    // @"suckEffect" // 收缩抽纸效果
    // @"rippleEffect" // 水波效果
    // @"cameraIrisHollowOpen" // 相机镜头打开
    // @"cameraIrisHollowClose" // 相机镜头关闭
    anima.subtype = kCATransitionFromLeft;
    // kCATransitionFromRight
    // kCATransitionFromLeft
    // kCATransitionFromTop
    // kCATransitionFromBottom
    anima.duration = 1.f;
//    // 从哪开始
//    anima.startProgress = 0.2;
//    // 到哪结束
//    anima.endProgress = 0.5;
    [_aLayer addAnimation:anima forKey:@"new"];
}


#pragma mark CAAnimationGroup
- (void)addCAAnimationGroup {
    CABasicAnimation *anima1 = [CABasicAnimation animation];
    anima1.keyPath = @"position.y";
    anima1.toValue = @(400);
    
    CABasicAnimation *anima2 = [CABasicAnimation animation];
    anima2.keyPath = @"transform.scale";
    anima2.toValue = @(0.5);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anima1, anima2];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = 1.f;
    [_aLayer addAnimation:group forKey:@"new"];
}

// 核心动画 和 UIView动画 的区别
// 1 核心动画仅作用于 Layer
// 2 核心动画看到的一切皆假象，不会真正修改属性值

// 使用时机
// 1 需要与用户交互，用 UIView动画
// 2 过度时， 帧动画 用路径时 用 核心动画
- (void)addUIViewAnimation {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self addSubview:view];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
