//
//  BLInvertedImage.m
//  DemoOC
//
//  Created by bailong on 2021/8/6.
//

#import "BLInvertedImage.h"

@interface BLInvertedImage ()

{
    CGRect _oriFrame;
    UIImageView *_ivImage;
    CAReplicatorLayer *_rLayer;
}

@end

@implementation BLInvertedImage

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _oriFrame = frame;
        _space = 2.f;
        _isLeft = YES;
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setUp {
    UIImageView *iv = [[UIImageView alloc] init];
    [self addSubview:iv];
    _ivImage = iv;
    
    CGFloat w = _oriFrame.size.width;
    CGFloat h = _oriFrame.size.height;
    // 设置自身frame
    CGRect rect = _oriFrame;
    rect.size.height = (h + _space) * 2.f;
    self.frame = rect;
    
    // 设置图片
    rect = CGRectMake(0.f, 0.f, w, h);
    _ivImage.frame = rect;
    
    // 倒影层
    CAReplicatorLayer *tmpRLayer = [CAReplicatorLayer layer];
    tmpRLayer.frame = self.bounds;
    tmpRLayer.instanceCount = 2;
    tmpRLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//        tmpRLayer.instanceRedOffset -= 0.5;
//        tmpRLayer.instanceGreenOffset -= 0.5;
//        tmpRLayer.instanceBlueOffset -= 0.5;
    tmpRLayer.instanceAlphaOffset -= 0.5;
    [tmpRLayer addSublayer:_ivImage.layer];
    [self.layer addSublayer:tmpRLayer];
    _rLayer = tmpRLayer;
    
    CAGradientLayer *gLayer = [CAGradientLayer layer];
    gLayer.frame = CGRectMake(0.f, h + _space * 2.f, w, h);
    gLayer.colors = @[
                    (id)[UIColor blackColor].CGColor,
                    (id)[UIColor clearColor].CGColor
                    ];
    gLayer.locations = @[@(0.4), @(0.8)];
    gLayer.startPoint = CGPointMake(0, 1);
    gLayer.endPoint = CGPointZero;
    [self.layer addSublayer:gLayer];
}

//+ (Class)layerClass {
//    return [CAReplicatorLayer class];
//}
- (void)setImage:(UIImage *)image {
    _image = image;
    _ivImage.image = image;
}
- (void)setIsLeft:(BOOL)isLeft {
    _isLeft = isLeft;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = (_isLeft ? -1 : 1) / 300.f;
    CGFloat angle = M_PI_4;
    self.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
