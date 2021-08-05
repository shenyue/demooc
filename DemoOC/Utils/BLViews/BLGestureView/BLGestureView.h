//
//  BLGestureView.h
//  DemoOC
//
//  Created by bailong on 2021/7/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLGestureView : UIView

- (void)addGestureDelegate;

- (void)addTapGestureRecognizer;
- (void)addSwipeGestureRecognizer;
- (void)addLongPressGestureRecognizer;
- (void)addPanGestureRecognizer;
- (void)addRotationGestureRecognizer;
- (void)addPinchGestureRecognizer;

@end

NS_ASSUME_NONNULL_END
