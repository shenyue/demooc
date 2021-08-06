//
//  BLInvertedImage.h
//  DemoOC
//
//  Created by bailong on 2021/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLInvertedImage : UIView

@property (nonatomic, assign) BOOL isLeft;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, retain) UIImage *image;

@end

NS_ASSUME_NONNULL_END
