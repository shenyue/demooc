//
//  BLGestureLock.m
//  DemoOC
//
//  Created by bailong on 2021/8/2.
//

#import "BLGestureLock.h"

@interface BLGestureLock ()

{
    int _column;
    int _row;
}


@property (nonatomic) CGPoint curPoint;

@property (nonatomic, strong) NSMutableArray *selectedBtns;

@end


@implementation BLGestureLock

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)layoutSubviews {
    [super layoutSubviews];
  
//    [self marginLayout];
    [self noMarginLayout];
//    [self marginLayout2D];
//    [self noMarginLayout2D];
}
- (NSMutableArray *)selectedBtns {
    if (_selectedBtns == nil) {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}
- (void)marginLayout {
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat w = 70.f;
    CGFloat h = 70.f;
    CGFloat hs = (self.bounds.size.width - w * _column) / (_column + 1);
    CGFloat vs = (self.bounds.size.height - h * _row) / (_row + 1);
    for (NSInteger i=0; i<(_row * _column); i++) {
        x = (w + hs) * (i % _column) + hs;
        y = (h + vs) * (i / _column) + vs;
        UIButton *btn = (UIButton *)self.subviews[i];
        btn.tag = i;
        btn.frame = CGRectMake(x, y, w, h);
    }
}
- (void)noMarginLayout {
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat w = 70.f;
    CGFloat h = 70.f;
    CGFloat hs = (self.bounds.size.width - w * _column) / (_column - 1);
    CGFloat vs = (self.bounds.size.height - h * _row) / (_row - 1);
    for (NSInteger i=0; i<(_row * _column); i++) {
        x = (w + hs) * (i % _column);
        y = (h + vs) * (i / _column);
        UIButton *btn = (UIButton *)self.subviews[i];
        btn.tag = i;
        btn.frame = CGRectMake(x, y, w, h);
    }
}
- (void)marginLayout2D {
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat w = 70.f;
    CGFloat h = 70.f;
    CGFloat hs = (self.bounds.size.width - w * _column) / (_column + 1);
    CGFloat vs = (self.bounds.size.height - h * _row) / (_row + 1);
    NSInteger index = 0;
    for (NSInteger i=0; i<_row; i++) {
        for (NSInteger j=0; j<_column; j++) {
            index = i * _column + j;
            x = (w + hs) * j + hs;
            y = (h + vs) * i + vs;
            UIButton *btn = (UIButton *)self.subviews[index];
            btn.tag = i;
            btn.frame = CGRectMake(x, y, w, h);
        }
    }
}
- (void)noMarginLayout2D {
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat w = 70.f;
    CGFloat h = 70.f;
    CGFloat hs = (self.bounds.size.width - w * _column) / (_column - 1);
    CGFloat vs = (self.bounds.size.height - h * _row) / (_row - 1);
    NSInteger index = 0;
    for (NSInteger i=0; i<_row; i++) {
        for (NSInteger j=0; j<_column; j++) {
            index = i * _column + j;
            x = (w + hs) * j;
            y = (h + vs) * i;
            UIButton *btn = (UIButton *)self.subviews[index];
            btn.tag = i;
            btn.frame = CGRectMake(x, y, w, h);
        }
    }
}
// d81e06
- (void)setUp {
    _column = 3;
    _row = 3;
    for (NSInteger i=0; i<(_row * _column); i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.userInteractionEnabled = NO;
        UIImage *normal = [UIImage imageNamed:@"btn"];
        UIImage *selected = [UIImage imageNamed:@"btns"];
        [btn setBackgroundImage:normal forState:UIControlStateNormal];
        [btn setBackgroundImage:selected forState:UIControlStateSelected];
        [self addSubview:btn];
    }
}

// 获取当前点
- (void)pointInView:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    self.curPoint = [touch locationInView:self];
}
// 点在哪个按钮上
- (UIButton *)selectedButton {
    for (UIButton *btn in self.subviews) {
        // 判断一个点在不在指定区域
        if (CGRectContainsPoint(btn.frame, self.curPoint)) {
            return btn;
        }
    }
    return nil;
}


#pragma mark Touches Functions
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 点在按钮上，则按钮选中状态
    [self pointInView:touches];
    UIButton *btn = [self selectedButton];
    if (btn && btn.selected == NO) {
        [self.selectedBtns addObject:btn];
        btn.selected = true;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self pointInView:touches];
    UIButton *btn = [self selectedButton];
    if (btn && btn.selected == NO) {
        [self.selectedBtns addObject:btn];
        btn.selected = true;
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UIButton *btn in self.selectedBtns) {
        btn.selected = NO;
    }
    [self.selectedBtns removeAllObjects];
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"%ld", self.selectedBtns.count);
    if (self.selectedBtns.count > 0) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        for (int i=0; i<self.selectedBtns.count; i++) {
            UIButton *btn = self.selectedBtns[i];
            if (i == 0) {
                [path moveToPoint:btn.center];
            } else {
                [path addLineToPoint:btn.center];
            }
        }
        //
        [path addLineToPoint:self.curPoint];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path setLineWidth:10];
        [[UIColor redColor] set];
        [path stroke];
    }
}


@end
