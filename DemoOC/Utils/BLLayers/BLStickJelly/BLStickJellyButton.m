//
//  BLStickJellyButton.m
//  DemoOC
//
//  Created by bailong on 2021/8/10.
//

#import "BLStickJellyButton.h"

@interface BLStickJellyButton ()

@property (nonatomic, weak) UIView *vSc;

@end

@implementation BLStickJellyButton

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
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.backgroundColor = [UIColor redColor];
    [self setTintColor:[UIColor whiteColor]];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}
- (void)pan:(UIPanGestureRecognizer *)gesture {
    CGPoint p = [gesture locationInView:gesture.view];
    // transform 不能修改center
    // transform 修改的是frame
//    self.transform = CGAffineTransformTranslate(self.transform, p.x, p.y);
//
    
    CGPoint c = self.center;
    c.x += p.x;
    c.y += p.y;
    self.center = c;
    
    [gesture setTranslation:CGPointZero inView:self];
    
    // 计算两圆之间距离
    CGFloat d = [self distView:self.vSc withView:self];
    
    // 缩放小圆
    // 获取小圆半径
    CGFloat s = self.bounds.size.width * 0.5;
    // 缩小半径
    s = s - d / 10.f;
    self.vSc.bounds = CGRectMake(0.f, 0.f, s * 2.f, s * 2.f);
    self.vSc.layer.cornerRadius = s;
}
- (UIView *)vSc {
    if (_vSc == nil) {
        UIView *view = [[UIView alloc] init];
        view.frame = self.frame;
        view.layer.cornerRadius = view.bounds.size.width * 0.5;
        view.backgroundColor = [UIColor blueColor];
        NSLog(@"%@", self.superview);
        [self.superview insertSubview:view belowSubview:self];
        _vSc = view;
    }
    return _vSc;
}

// 形状图层
// 根据路径生成形状
- (void)shape {
    
}
- (CGFloat)distView:(UIView *)v1 withView:(UIView *)v2 {
    CGFloat offsetX = v2.center.x - v1.center.x;
    CGFloat offsetY = v2.center.y - v1.center.y;
    CGFloat d = sqrt(offsetX * offsetX + offsetY * offsetY);
    return d;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
