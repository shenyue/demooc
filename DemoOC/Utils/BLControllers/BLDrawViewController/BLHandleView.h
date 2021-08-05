//
//  BLHandleView.h
//  DemoOC
//
//  Created by bailong on 2021/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BLHandleView;
typedef void(^ClipBlock)(BLHandleView *view, UIImage *image);

@interface BLHandleView : UIView

@property (nonatomic, weak) UIImage *image;
@property (nonatomic, weak) UIImageView *ivImage;
@property (nonatomic, copy) ClipBlock clipBlock;

@end

NS_ASSUME_NONNULL_END
