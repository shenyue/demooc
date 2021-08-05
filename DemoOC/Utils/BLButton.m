//
//  BLButton.m
//  DemoOC
//
//  Created by Ares on 2021/7/9.
//

#import "BLButton.h"

@implementation BLButton

// imageRectForContentRect 和 titleRectForContentRect 谁被先调用不一定
// 返回图片的react
// 通常contentRect=按钮的bounds
//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
//}
// 返回文字的react
//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(0, contentRect.size.width, contentRect.size.width, contentRect.size.height - contentRect.size.width);
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 布局
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
