//
//  BLWatermarkView.m
//  DemoOC
//
//  Created by Ares on 2021/8/1.
//

#import "BLWatermarkView.h"

@interface BLWatermarkView ()
@end
@implementation BLWatermarkView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _sourceImage = nil;
        _watermarkText = nil;
    }
    return self;
}

- (UIImage *)createWatermarkImage {
    // 1 手动开启上下文
    UIGraphicsBeginImageContext(self.sourceImage.size);
    // 2 绘制内容到上下文
    [self.sourceImage drawAtPoint:CGPointZero];
    NSDictionary *dic = @{
        NSFontAttributeName: [UIFont systemFontOfSize:100],
//        NSForegroundColorAttributeName: [UIColor redColor],
        NSStrokeColorAttributeName: [UIColor whiteColor],
        NSStrokeWidthAttributeName: @3,
    };
    [self.watermarkText drawAtPoint:CGPointMake(100, 100) withAttributes:dic];
    // 3 从上下文中生成合成图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    // 4 手动销毁
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
