//
//  Tools.h
//  DemoOC
//
//  Created by bailong on 2021/7/8.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject


// 路径相关
+ (NSString *)dir_home;
+ (NSString *)dir_document;
+ (NSString *)dir_documentFile:(NSString *)fileName;
+ (NSString *)dir_bySearchPath:(NSSearchPathDirectory)directory;
+ (NSString *)dir_bySearchPath:(NSSearchPathDirectory)directory fileName:(NSString *)fileName;

/**
 返回可拉伸的图片
 */
+ (UIImage *)resizingImageWithName:(NSString *)name;
+ (void)setAppBadge:(NSInteger)value;
+ (void)setNetState;
+ (void)openUrl:(NSURL *)url;
+ (void)setStatusBar:(UIStatusBarStyle)style;
+ (void)setStatusHidden:(BOOL)hidden;
+ (void)setStatusBarOrientation:(UIInterfaceOrientation)orientation;
+ (void)statusBarFrame;

@end

NS_ASSUME_NONNULL_END
