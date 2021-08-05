//
//  BLDrawView.m
//  DemoOC
//
//  Created by bailong on 2021/8/4.
//

#import "BLDrawView.h"
#import "BLBezierPath.h"

@interface BLDrawView ()

@property (nonatomic, strong) BLBezierPath *path;

@property (nonatomic, strong) NSMutableArray *pathArray;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIColor *color;


@end

@implementation BLDrawView

- (NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.width = 1;
    self.color = [UIColor blackColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}
- (void)pan:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        BLBezierPath *path = [BLBezierPath bezierPath];
        path.lineWidth = self.width;
        path.color = self.color;
        path.lineJoinStyle = kCGLineJoinRound;
        path.lineCapStyle = kCGLineCapRound;
        
        self.path = path;
        [self.path moveToPoint:point];
        [self.pathArray addObject:path];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:point];
        [self setNeedsDisplay];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        
    }
}

- (void)clear {
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}
- (void)undo {
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)erase {
    
}


- (void)setImage:(UIImage *)img {
    [self.pathArray addObject:img];
    [self setNeedsDisplay];
}
- (void)photo {
}
- (void)save {
    
}

- (void)setLineColor:(UIColor *)color {
    self.color = color;
}

- (void)setLineWidth:(CGFloat)width {
    self.width = width;
}


- (void)drawRect:(CGRect)rect {
    for (BLBezierPath *path in self.pathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *img = (UIImage *)path;
            [img drawInRect:rect];
        } else {
            [path.color set];
            [path stroke];
        }
    }
}


@end
