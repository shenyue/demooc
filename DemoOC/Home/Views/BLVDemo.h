//
//  BLVDemo.h
//  DemoOC
//
//  Created by bailong on 2021/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BLMCity;
@interface BLVDemo : UIView

@property (nonatomic, strong) BLMCity *data;

- (instancetype) initWithData:(BLMCity *)data;
+ (instancetype) vdemoWithData:(BLMCity *)data;
+ (instancetype) viewFromXib;

@end

NS_ASSUME_NONNULL_END
