//
//  BLCADisplayLinkView.m
//  DemoOC
//
//  Created by Ares on 2021/8/1.
//

#import "BLCADisplayLinkView.h"

@interface BLCADisplayLinkView ()

{
   
}

@end

@implementation BLCADisplayLinkView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

- (void)openTimer {
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(update) userInfo:nil repeats:YES];
}
- (void)openDisplayLink {
    // setNeedsDisplay 会调用 drawRect
    // 但并不是执行调用，而是当屏幕刷新的时候才执行 drawRect
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
static int _y = 0;
- (void)update {
    _y += 10;
    if (_y > [[UIScreen mainScreen] bounds].size.height) {
        _y = 0;
    }
    // 刷新
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImage *imgSnow = [UIImage imageNamed:@"vip"];
    [imgSnow drawAtPoint:CGPointMake(10, _y)];
}


@end
