//
//  BLLayer.m
//  DemoOC
//
//  Created by bailong on 2021/8/4.
//

#import "BLLayer.h"

@interface BLLayer ()

{
    UIView *_view;
    UIImageView *_ivView;
    CALayer *_pLayer; // 父
    CALayer *_cLayer; // 子
    CATextLayer *_tLayer;
}

@end

@implementation BLLayer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGRect frame = CGRectMake(50, 100, 100, 100);
        _view = [[UIView alloc] initWithFrame:frame];
        _view.backgroundColor = [UIColor blueColor];
        [self addSubview:_view];
        _view.layer.borderColor = [UIColor redColor].CGColor;
        // borderWidth 是向内
        _view.layer.borderWidth = 5.f;
        _view.layer.shadowOpacity = 1.f;
        _view.layer.shadowColor = [UIColor greenColor].CGColor;
        _view.layer.shadowOffset = CGSizeMake(10.f, 10.f);
        _view.layer.cornerRadius = 50.f;
//        _view.clipsToBounds = YES;
        
        frame = CGRectMake(250, 100, 100, 100);
        _ivView = [[UIImageView alloc] initWithFrame:frame];
        UIImage *img = [UIImage imageNamed:@"bz"];
        _ivView.image = img;
        [self addSubview:_ivView];
        _ivView.layer.borderColor = [UIColor redColor].CGColor;
        _ivView.layer.borderWidth = 5.f;
        _ivView.layer.shadowOpacity = 1.f;
        _ivView.layer.shadowColor = [UIColor greenColor].CGColor;
        _ivView.layer.shadowOffset = CGSizeMake(10.f, 10.f);
        // radius是作用在layer上，而图片是在 layer.contents上
        _ivView.layer.cornerRadius = 50.f;
//        _ivView.layer.masksToBounds = YES;
        
        [self addPosition];
        [self addBtns];
    }
    return self;
}

- (void)addPosition {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(150, 300, 200, 200);
    layer.opacity = 0.5;
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:layer];
    _pLayer = layer;
    
    layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.opacity = 0.8;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [_pLayer addSublayer:layer];
    _cLayer = layer;
    
    CATextLayer *tlayer = [CATextLayer layer];
    tlayer.frame = CGRectMake(0, 0, 100, 100);
    tlayer.opacity = 0.8;
    tlayer.wrapped = YES;
    UIFont *font = [UIFont systemFontOfSize:18.0];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef =CGFontCreateWithFontName(fontName);
    tlayer.font = fontRef;
    tlayer.fontSize = font.pointSize;
    [_cLayer addSublayer:tlayer];
    _tLayer = tlayer;
}

- (void)addBtns {
    UIView *vBtn = [[UIView alloc] initWithFrame:CGRectMake(30, 600, self.bounds.size.width-60, 120)];
    vBtn.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:vBtn];
    
    int _row = 3;
    int _column = 3;
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat w = 60.f;
    CGFloat h = 40.f;
    CGFloat hs = (vBtn.bounds.size.width - w * _column) / (_column - 1);
    CGFloat vs = (vBtn.bounds.size.height - h * _row) / (_row - 1);
    CGRect frame;
    NSArray *texts = @[
        @"0,0"  , @"0.5,0"  , @"1,0",
        @"0,0.5", @"0.5,0.5", @"1,0.5",
        @"0,1"  , @"0.5,1"  , @"1,1"
        ];
    for (int i=0; i<(_row * _column); i++) {
        x = (w + hs) * (i % _column);
        y = (h + vs) * (i / _row);
        frame = CGRectMake(x, y, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        btn.tag = i;
        [btn setTitle:texts[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(setPositionAndAnchorPoint:) forControlEvents:UIControlEventTouchUpInside];
        [vBtn addSubview:btn];
    }
}
- (void)setPositionAndAnchorPoint:(UIButton *)btn {
    // 每个View默认都会关联一个layer对象，我们其为根layer
    // 对于更改非 根Layer 的属性，都会有隐式动画
    // 禁用隐式动画
//    [CATransaction setDisableActions:YES];
    // 设置动画时间
//    [CATransaction setAnimationDuration:3.f];
    
    // 开启事务
//    [CATransaction begin];
    // 提交事务
//    [CATransaction commit];
    NSArray *arr = [btn.currentTitle componentsSeparatedByString:@","];
    _cLayer.anchorPoint = CGPointMake([arr[0] floatValue], [arr[1] floatValue]);
    _tLayer.string = [NSString stringWithFormat:@"AnchorPoint%@", btn.currentTitle];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __block BLLayer *selfBlock = self;
    [UIView animateWithDuration:0.25f animations:^{
//        selfBlock->_ivView.layer.transform = CATransform3DRotate(selfBlock->_ivView.layer.transform, M_PI, 1, 1, 0);
//        selfBlock->_ivView.layer.transform = CATransform3DTranslate(        selfBlock->_ivView.layer.transform, 50.f, 50.f, 100);
//        selfBlock->_ivView.layer.transform = CATransform3DScale(selfBlock->_ivView.layer.transform, 1.5f, 1.5f, 1.5f);
        NSValue *val = [NSValue valueWithCATransform3D:CATransform3DTranslate(        selfBlock->_ivView.layer.transform, 50.f, 50.f, 100)];
        [selfBlock->_ivView.layer setValue:val forKey:@"transform"];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
