//
//  UIImage+Resizing.h
//  DemoOC
//
//  Created by bailong on 2021/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Resizing)

/**
 返回可拉伸的图片
 */
+ (UIImage *)resizingImageWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
