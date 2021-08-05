//
//  main.m
//  DemoOC
//
//  Created by bailong on 2021/7/7.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    return UIApplicationMain(argc, argv, @"UIApplication", @"AppDelegate");
    /**
                            
            1  执行 load()，把所有载入内存；然后 执行main()
            2  执行UIApplicationMain
                2.1  会创建 UIApplication 对象，并设置其代理
                2.2  会开启一个事件循环（主运行循环，死循环，保证应用程序不退出）
                2.3  加载 info.plist 文件，判断是否指定 UIMainStoryboardFile （Main）
                    如果指定了，显示Main.storyboard中箭头指向的ViewController的view
                2.4  通知应用程序代理，应用启动完毕，didFinishLaunchingWithOptions
     */
}
