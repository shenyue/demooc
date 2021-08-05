//
//  UIImage+Resizing.m
//  DemoOC
//
//  Created by bailong on 2021/7/14.
//

#import "UIImage+Resizing.h"

@implementation UIImage (Resizing)

+ (UIImage *)resizingImageWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGFloat imgHW = image.size.width * 0.5;
    CGFloat imgHH = image.size.height * 0.5;
    UIImage *resizeImg = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imgHH, imgHW, imgHH-1, imgHW-1) resizingMode:UIImageResizingModeStretch];
    return resizeImg;
}

@end
