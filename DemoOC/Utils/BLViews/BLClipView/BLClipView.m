//
//  BLClipView.m
//  DemoOC
//
//  Created by Ares on 2021/8/2.
//

#import "BLClipView.h"


@interface BLClipView ()

{
    CGPoint _pStart;
    UIPanGestureRecognizer *_ccpan; // 自定义裁剪手势
    
    UIImageView *_ivBottom; // 底板图片
    UIImageView *_ivTop; // 顶层图片
    UIPanGestureRecognizer *_epan; // 橡皮擦手势
}

@property (nonatomic, weak) UIView *coverView;

@end


@implementation BLClipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _sourceImage = nil;
        
    }
    return self;
}
- (void)addCustomerClipPan {
    if (_ccpan == nil) {
        _ccpan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:_ccpan];
    }
    if (_ivTop == nil) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:self.sourceImage];
        iv.frame = self.bounds;
        [self addSubview:iv];
        _ivTop = iv;
    }
}
- (void)pan:(UIPanGestureRecognizer *)gesture {
    // 一定要注意此 inview 的对象，因为坐标系
    CGPoint p = [gesture locationInView:self];
    CGRect frame = CGRectZero;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _pStart = p;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat x = _pStart.x;
        CGFloat y = _pStart.y;
        CGFloat w = p.x - _pStart.x;
        CGFloat h = p.y - _pStart.y;
        frame = CGRectMake(x, y, w, h);
        self.coverView.frame = frame;
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.coverView removeFromSuperview];
        
        UIGraphicsBeginImageContextWithOptions(_ivTop.bounds.size, NO, 0.0f);
        UIRectClip(self.coverView.frame);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:ctx];
        UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _ivTop.image = newImg;
        
        if (self.clipBlock) {
            self.clipBlock(self, newImg);
        }
    }
}

- (void)addEraserPan {
    if (_epan == nil) {
        _epan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(eraser:)];
        [self addGestureRecognizer:_epan];
    }
    if (_ivBottom == nil) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:self.sourceImage];
        iv.frame = self.bounds;
        [self addSubview:iv];
        _ivBottom = iv;
    }
    if (_ivTop == nil) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:self.sourceImage2];
        iv.frame = self.bounds;
        [self addSubview:iv];
        _ivTop = iv;
    }
}
- (void)eraser:(UIPanGestureRecognizer *)gesture {
    CGPoint p = [gesture locationInView:self];
    CGRect frame = CGRectMake(p.x-15.f, p.y-15.f, 30.f, 30.f);
    UIGraphicsBeginImageContextWithOptions(_ivTop.bounds.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [_ivTop.layer renderInContext:ctx];
    CGContextClearRect(ctx, frame);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    _ivTop.image = newImg;
    UIGraphicsEndImageContext();
}

- (UIView *)coverView {
    if (_coverView == nil) {
        UIView *view = [[UIView alloc] init];
        view.alpha = 0.7;
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        _coverView = view;
    }
    return _coverView;
}

- (UIImage *)createClipImage {
    // 1 手动开启上下文
    UIGraphicsBeginImageContext(self.sourceImage.size);
    // 2 设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, self.sourceImage.size.width, self.sourceImage.size.height)];
    // 3 把路径设置为裁剪区域
    // 对后面绘制的内容有效果，已绘制的无效果
    [path addClip];
    // 4 绘制内容到上下文
    [self.sourceImage drawAtPoint:CGPointZero];
    // 5 获取图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    // 6 关闭上下文
    UIGraphicsEndImageContext();
    return newImg;
}

- (UIImage *)createClipImageWithBorder {
    CGFloat borderWidth = 10.f;
    // 1 手动开启上下文
    
    CGSize size = CGSizeMake(self.sourceImage.size.width + borderWidth*2, self.sourceImage.size.height+borderWidth*2);
    UIGraphicsBeginImageContext(size);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, size.width, size.height)];
    [[UIColor lightGrayColor] set];
    [path fill];
    
    // 2 设置裁剪区域
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, self.sourceImage.size.width, self.sourceImage.size.height)];
    // 3 把路径设置为裁剪区域
    // 对后面绘制的内容有效果，已绘制的无效果
    [path2 addClip];
    // 4 绘制内容到上下文
    [self.sourceImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    // 5 获取图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    // 6 关闭上下文
    UIGraphicsEndImageContext();
    return newImg;
}

- (UIImage *)createClipScreen {
//    UIGraphicsBeginImageContext(self.bounds.size);
    // size
    // 透明: YES不透明
    // 缩放比率: 0.0 相当于  [UIScreen mainScreen].scale
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImageJPEGRepresentation(newImg, 1.f);
    [data writeToFile:@"/Users/ares/Desktop/bz.jpg" atomically:YES];
//    NSData *data = UIImagePNGRepresentation(newImg);
//    [data writeToFile:@"/Users/ares/Desktop/bz.png" atomically:YES];
    UIGraphicsEndImageContext();
    return newImg;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
