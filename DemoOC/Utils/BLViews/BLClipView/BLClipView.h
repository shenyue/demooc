//
//  BLClipView.h
//  DemoOC
//
//  Created by Ares on 2021/8/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BLClipView;
typedef void(^ClipBlock)(BLClipView *view, UIImage *image);

@interface BLClipView : UIView

// 原图
@property (nonatomic, weak) UIImage *sourceImage;
@property (nonatomic, weak) UIImage *sourceImage2;

@property (nonatomic) ClipBlock clipBlock;

- (UIImage *)createClipImage;

- (UIImage *)createClipImageWithBorder;

- (UIImage *)createClipScreen;

- (void)addCustomerClipPan;
- (void)addEraserPan;

@end

NS_ASSUME_NONNULL_END
