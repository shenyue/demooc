//
//  BLAlertController.m
//  DemoOC
//
//  Created by bailong on 2021/7/26.
//

#import "BLAlertController.h"


@interface BLAlertController ()

@end

@implementation BLAlertController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setItems:(NSArray *)items {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = nil;
//    action = [UIAlertAction actionWithTitle:<#(nullable NSString *)#> style:<#(UIAlertActionStyle)#> handler:<#^(UIAlertAction * _Nonnull action)handler#>]
//    [alert addAction:action];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
