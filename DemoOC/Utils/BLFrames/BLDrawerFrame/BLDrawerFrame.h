//
//  BLDrawerFrame.h
//  DemoOC
//
//  Created by bailong on 2021/7/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLDrawerFrame : UIView

// 主View
@property (nonatomic, weak, readonly) UIView *vMain;
// 次级View
@property (nonatomic, weak, readonly) UIView *vSecondary;
// 位移比率 或者 展示宽度
// 按位移比率: 0.05 < ratio < 1, default ratio = 0.8; 数值越大 展示越少
// 按展示宽度: 1 < ratio < self.frame.size.width, default ratio = 20
@property (nonatomic, assign, setter=setRatio:) CGFloat ratio;
// 缩放比率 0.5 < scale < 1, default scale = 1; 数值越大 缩放程度越小, scale = 1 为不缩放
@property (nonatomic, assign, setter=setScale:) CGFloat scale;
// 缩放 跟随 位移比率 或者 展示宽度, default scaleByRatio = NO
@property (nonatomic, assign) BOOL isScaleWithRatio;

/**
 打开
 */
- (void)open;
/**
 关闭
 */
- (void)close;

@end

NS_ASSUME_NONNULL_END
