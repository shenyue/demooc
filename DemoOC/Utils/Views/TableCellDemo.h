//
//  TableCellDemo.h
//  DemoOC
//
//  Created by bailong on 2021/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef MC_TableCellViewModelDemo_nameFont
#define MC_TableCellViewModelDemo_nameFont [UIFont systemFontOfSize:16]
#endif

#ifndef MC_TableCellViewModelDemo_messageFont
#define MC_TableCellViewModelDemo_messageFont [UIFont systemFontOfSize:14]
#endif

#ifndef MC_TableCellViewModelDemo_ScreenSize
#define MC_TableCellViewModelDemo_ScreenSize [[UIScreen mainScreen] bounds].size
#endif

/**
 cell 式样 model
 */
@class TableCellModelDemo;
@interface TableCellViewModelDemo : NSObject

@property(nonatomic, assign) CGRect avatarFrame;
@property(nonatomic, assign) CGRect nameFrame;
@property(nonatomic, assign) CGRect vipIconFrame;
@property(nonatomic, assign) CGRect messageFrame;
@property(nonatomic, assign) CGRect pictureFrame;

@property(nonatomic, copy) UIFont *nameFont;
@property(nonatomic, copy) UIFont *messageFont;

- (CGFloat)cellHeight:(TableCellModelDemo *)model;
- (NSString *)description;

@end






/**
 cell 数据源 model
 */
@interface TableCellModelDemo : NSObject

@property(nonatomic, copy) NSString *avatarIcon;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) BOOL isVip;
@property(nonatomic, copy) NSString *vipIcon;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, copy) NSString *picture;

- (CGFloat)cellHeight;
- (TableCellViewModelDemo *)viewModel;
- (NSString *)description;

@end






/**
 celll
 */
@interface TableCellDemo : UITableViewCell

- (void)setModel:(TableCellModelDemo *)model;

@end

NS_ASSUME_NONNULL_END
