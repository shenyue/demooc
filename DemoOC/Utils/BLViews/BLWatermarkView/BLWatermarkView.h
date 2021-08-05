//
//  BLWatermarkView.h
//  DemoOC
//
//  Created by Ares on 2021/8/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BLWatermarkView;

//typedef void(^createWatermarkBlock)(BLWatermarkView *view);

@interface BLWatermarkView : UIView

// 原图
@property (nonatomic, weak) UIImage *sourceImage;
// 水印
@property (nonatomic, strong) NSString *watermarkText;

// 创建图片
- (UIImage *)createWatermarkImage;

@end

NS_ASSUME_NONNULL_END
