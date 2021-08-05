//
//  DemoCode.m
//  DemoOC
//
//  Created by Ares on 2021/7/9.
//

#import "DemoCode.h"
#import <UIKit/UIKit.h>

@implementation DemoCode

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.age forKey:@"age"];
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntegerForKey:@"age"];
    }
    return self;
}

- (void)animation:(UIView *)view {
    [UIView animateWithDuration:2 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:2 delay:1 options:kNilOptions animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
