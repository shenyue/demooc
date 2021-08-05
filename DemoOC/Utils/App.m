//
//  App.m
//  DemoOC
//
//  Created by bailong on 2021/7/24.
//

#import "App.h"

@implementation App

// 1 应用一启动创建该对象
// 2 通过shareApp返回对象都是同一个地址（单例）
// 3 调用alloc挂掉
static App *_app;

+ (void)load {
    _app = [[self alloc] init];
}

+ (App *)shareApp {
    return _app;
}

+ (instancetype)alloc {
    if (_app) {
        // 挂掉，抛出异常
        NSException *exp = [NSException exceptionWithName:@"App创建错误" reason:@"请使用[App shareApp]创建App对象" userInfo:nil];
        [exp raise];
    }
    return [super alloc];
}

@end
