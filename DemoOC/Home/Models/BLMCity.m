//
//  BLMCity.m
//  DemoOC
//
//  Created by bailong on 2021/7/8.
//

#import "BLMCity.h"

@interface BLMCity()

{
    @private
    NSString *level;
}

@end

@implementation BLMCity

- (instancetype) initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.city = dic[@"city"];
        self.area = dic[@"area"];
    }
    return self;
}

+ (instancetype) cityWithDictionary:(NSDictionary *)dic {
    BLMCity *model = [[self alloc] initWithDictionary:dic];
    return model;
}

- (NSString *)getLevel {
    return level;
}

@end
