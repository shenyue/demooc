//
//  BLQuartz2dView.m
//  DemoOC
//
//  Created by Ares on 2021/7/31.
//

#import "BLQuartz2dView.h"

@interface BLQuartz2dView ()
{
    CGFloat _startArc;
}
@end

@implementation BLQuartz2dView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _startArc = -(M_PI * 0.5);
        _endArc = 0;
    }
    return self;
}

- (CGFloat)toArc:(CGFloat)v {
//    CGFloat t = v / 100.f * 2 * M_PI;
    CGFloat t = v * M_PI * 0.02;
    return t;
}
- (void)setEndArc:(CGFloat)v {
    v = v < 0 ? 0 : v;
    v = v > 100 ? 100 : v;
    _endArc = v;
    [self setNeedsDisplay];
}


// 作用 绘图
// 调用时机:  viewWillAppear 和 viewDidAppear 之间被调用
// 当系统调用 此方法，会自动创建 ctx
// 手动调用是不会创建 ctx 的, 应使用 setNeedDisplay 它会通知系统调用 drawRect
- (void)drawRect:(CGRect)rect {
//    [self drawLine];
//    [self drawCurveLine];
//    [self drawRoundedRect];
//    [self drawArc];
//    [self drawProgress];
    [self drawText];
}

- (void)drawText {
    NSString *str = @"Bai Long";
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowOffset =CGSizeMake(10.f, 10.f);
    shadow.shadowBlurRadius = 10.f;
    NSDictionary *dic = @{
        NSFontAttributeName: [UIFont systemFontOfSize:50],
        NSForegroundColorAttributeName: [UIColor redColor],
        NSStrokeColorAttributeName: [UIColor blueColor],
        NSStrokeWidthAttributeName: @3,
        NSShadowAttributeName: shadow,
    };
    [str drawAtPoint:CGPointMake(100.f, 200.f) withAttributes:dic];
}

- (void)drawProgress {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint c = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:c radius:100.f startAngle:_startArc endAngle: _startArc + [self toArc:_endArc] clockwise:YES];
    [[UIColor blueColor] set];
    CGContextSetLineWidth(ctx, 1);
    [path stroke];
}

- (void)drawLine {
    // 创建一个跟view相关联的上下文
    // 无论是开启，获取上下文，都以 UIGraphics 开头
   // 1 ctx 可以理解画板
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   // 2 获取画笔
   UIBezierPath *path = [UIBezierPath bezierPath];
   // 3 直线
   // 左边原点当前view的左上角
   [path moveToPoint:CGPointMake(100, 100)];
   [path addLineToPoint:CGPointMake(200, 300)];
   [path addLineToPoint:CGPointMake(300, 200)];
   
   CGContextSetLineWidth(ctx, 10.f);
   CGContextSetLineJoin(ctx, kCGLineJoinBevel);
   CGContextSetLineCap(ctx, kCGLineCapRound);
   // set 是 自动匹配 setStoke 或者 setFill
   [[UIColor redColor] set];
   
   // 把路径添加到上下文
   CGContextAddPath(ctx, path.CGPath);
   // 把ctx中的内容添加到view的layer上
   CGContextStrokePath(ctx);
}

- (void)drawCurveLine {
    // 创建一个跟view相关联的上下文
    // 无论是开启，获取上下文，都以 UIGraphics 开头
   // 1 ctx 可以理解画板
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   // 2 获取画笔
   UIBezierPath *path = [UIBezierPath bezierPath];
   // 3 直线
   // 左边原点当前view的左上角
   [path moveToPoint:CGPointMake(200, 200)];
   [path addCurveToPoint:CGPointMake(250, 250) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(300, 200)];
   CGContextSetLineWidth(ctx, 10.f);
   CGContextSetLineJoin(ctx, kCGLineJoinBevel);
   CGContextSetLineCap(ctx, kCGLineCapRound);
   // set 是 自动匹配 setStoke 或者 setFill
   [[UIColor blueColor] set];
   
   // 把路径添加到上下文
   CGContextAddPath(ctx, path.CGPath);
   // 把ctx中的内容添加到view的layer上
   CGContextStrokePath(ctx);

}

- (void)drawRoundedRect {
    // 创建一个跟view相关联的上下文
    // 无论是开启，获取上下文，都以 UIGraphics 开头
   // 1 ctx 可以理解画板
   CGContextRef ctx = UIGraphicsGetCurrentContext();
   // 2 获取画笔
   UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 300, 200, 100) cornerRadius:10];
   // 3 直线
   // 左边原点当前view的左上角
    
   CGContextSetLineWidth(ctx, 10.f);
   CGContextSetLineJoin(ctx, kCGLineJoinBevel);
   CGContextSetLineCap(ctx, kCGLineCapRound);
   // set 是 自动匹配 setStoke 或者 setFill
   [[UIColor blueColor] set];
   
   // 把路径添加到上下文
   CGContextAddPath(ctx, path.CGPath);
   // 把ctx中的内容添加到view的layer上
   CGContextStrokePath(ctx);

}

- (void)drawArc {
    CGPoint c = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:c radius:100.f startAngle:0 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:c];
    [[UIColor blueColor] set];
    [path fill];
}




@end
