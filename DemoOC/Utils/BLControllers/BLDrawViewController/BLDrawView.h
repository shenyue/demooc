//
//  BLDrawView.h
//  DemoOC
//
//  Created by bailong on 2021/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLDrawView : UIView

@property (nonatomic, strong) UIImage *image;

- (void)clear;
- (void)undo;
- (void)erase;
- (void)photo;
- (void)save;
- (void)setLineColor:(UIColor *)color;
- (void)setLineWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
