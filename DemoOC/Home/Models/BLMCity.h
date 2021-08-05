//
//  BLMCity.h
//  DemoOC
//
//  Created by bailong on 2021/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLMCity : NSObject

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;

- (instancetype) initWithDictionary:(NSDictionary *)dic;
+ (instancetype) cityWithDictionary:(NSDictionary *)dic;

- (NSString *)getLevel;

@end

NS_ASSUME_NONNULL_END
