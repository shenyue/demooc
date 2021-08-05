//
//  BLHandleView.m
//  DemoOC
//
//  Created by bailong on 2021/8/4.
//

#import "BLHandleView.h"

@interface BLHandleView ()<UIGestureRecognizerDelegate>



@end


@implementation BLHandleView

- (UIImageView *)ivImage {
    if (_ivImage == nil) {
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.frame = self.bounds;
        imgv.userInteractionEnabled = YES;
        [self addSubview:imgv];
        _ivImage = imgv;
        
        [self addGestures];
    }
    return _ivImage;
}

- (void)setImage:(UIImage *)img {
    _image = img;
    self.ivImage.image = img;
}

- (void)addGestures {
    [self addLongPressGestureRecognizer];
    [self addPanGestureRecognizer];
    [self addRotationGestureRecognizer];
    [self addPinchGestureRecognizer];
}

#pragma mark LongPress
- (void)addLongPressGestureRecognizer {
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.ivImage addGestureRecognizer:gesture];
}
- (void)longPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
//        __block BLHandleView *blockSelf = self;
        // 闪一下
        [UIView animateWithDuration:0.25f animations:^{
            self.ivImage.alpha = 0.f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25f animations:^{
                self.ivImage.alpha = 1.f;
            } completion:^(BOOL finished) {
                // 截屏
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0f);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                if (self.clipBlock) {
                    self.clipBlock(self, img);
                }
                [self removeFromSuperview];
            }];
        }];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"changed");
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
    }
}

#pragma mark Pan
- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.ivImage addGestureRecognizer:gesture];
}
- (void)pan:(UIPanGestureRecognizer *)gesture {
    // translationInView 计算出的偏移量 是相对原始点
    CGPoint p = [gesture translationInView:gesture.view];
    gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, p.x, p.y);
    // 清0
    [gesture setTranslation:CGPointZero inView:gesture.view];
}

#pragma mark Rotation
- (void)addRotationGestureRecognizer {
    UIRotationGestureRecognizer *gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.ivImage addGestureRecognizer:gesture];
    gesture.delegate = self;
}
- (void)rotation:(UIRotationGestureRecognizer *)gesture {
    // translationInView 计算出的偏移量 是相对原始点
    gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, gesture.rotation);
    // 清0
    gesture.rotation = 0;
}

#pragma mark Pinch
- (void)addPinchGestureRecognizer {
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.ivImage addGestureRecognizer:gesture];
    gesture.delegate = self;
}
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    // translationInView 计算出的偏移量 是相对原始点
    gesture.view.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);
    // 清0
    gesture.scale = 1;
}






#pragma mark GestureRecognizerDelegate Function
// 是否接收手指
// 如果判断某试图点击某部分是否响应手势，再此方法
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    CGPoint p = [touch locationInView:self];
//    if (p.y > self.bounds.size.height/2.f) {
//        return YES;
//    }
//    return NO;
//}
// 是否支持多个手势同时执行
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
