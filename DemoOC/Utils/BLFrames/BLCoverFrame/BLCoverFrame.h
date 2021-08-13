//
//  BLCoverFrame.h
//  DemoOC
//
//  Created by bailong on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, BLCoverFramePopupDirection) {
    BLCoverFramePopupDirectionFromBottom = 1,
    BLCoverFramePopupDirectionFromTop,
    BLCoverFramePopupDirectionFromLeft,
    BLCoverFramePopupDirectionFromRight,
    BLCoverFramePopupDirectionFromCenter,
    BLCoverFramePopupDirectionFromCustomToCenter,
};


@class BLCoverFrame;
@protocol BLCoverFrameDelegate <NSObject>

- (void)closeBLCoverFrame:(BLCoverFrame *)view;

@end

@interface BLCoverFrame : UIView

@property (nonatomic, weak) id<BLCoverFrameDelegate> delegate;

// 弹出位置
@property (nonatomic, assign) BLCoverFramePopupDirection diraction;
// 覆盖层颜色
@property (nonatomic, strong) UIColor *coverColor;
// 覆盖层透明度
@property (nonatomic, assign) CGFloat toCoverAlpha;
// 便宜位置 x
@property (nonatomic, assign) CGFloat offsetX;
// 便宜位置 y
@property (nonatomic, assign) CGFloat offsetY;
// 动画执行时间
@property (nonatomic, assign) NSTimeInterval duration;

- (instancetype)init;

- (void)showWithView:(UIView *)view;
- (void)showDirectionFromCenterWithView:(UIView *)view;
- (void)showDirectionFromCustomToCenterWithView:(UIView *)view;
- (void)closeView;

@end

NS_ASSUME_NONNULL_END
