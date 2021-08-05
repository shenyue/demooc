//
//  Tools.m
//  DemoOC
//
//  Created by bailong on 2021/7/8.
//

#import "Tools.h"

@implementation Tools


// 路径相关
+ (NSString *)dir_home {
    NSString *home = NSHomeDirectory();
    NSLog(@"home dir: %@\r\n", home);
    return home;
}
+ (NSString *)dir_document {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = dirs[0];
    NSLog(@"dir: %@\r\n", dir);
    return dir;
}
+ (NSString *)dir_documentFile:(NSString *)fileName {
    NSString *dir = [Tools dir_document];
    NSString *fullPath = [dir stringByAppendingPathComponent:fileName];
    NSLog(@"fullPath: %@\r\n", fullPath);
    return fullPath;
}
+ (NSString *)dir_bySearchPath:(NSSearchPathDirectory)directory {
    // NSLibraryDirectory  Library
    // NSDocumentDirectory  Documents
    // NSAutosavedInformationDirectory  Documents/Autosaved
    // NSCachesDirectory  Library/Caches
    
    // NSMoviesDirectory  ~/Movies
    // NSMusicDirectory  ~/Music
    // NSPicturesDirectory  ~/Pictures
    // NSPreferencePanesDirectory  Library/PreferencePanes
    // NSApplicationScriptsDirectory  ~/Library/Application Scripts/code-signing-id
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    NSString *dir = dirs[0];
    NSLog(@"dir: %@\r\n", dir);
    return dir;
}
+ (NSString *)dir_bySearchPath:(NSSearchPathDirectory)directory fileName:(NSString *)fileName {
    NSString *dir = [Tools dir_bySearchPath:directory];
    NSString *fullPath = [dir stringByAppendingPathComponent:fileName];
    NSLog(@"fullPath: %@\r\n", fullPath);
    return fullPath;
}

+ (void)w_archiveRootObject:(id)object toFile:(NSString *)file {
    [NSKeyedArchiver archiveRootObject:object toFile:file];
}
+ (id)r_unarchiveWithFile:(NSString *)file {
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    return obj;
}




+ (UIImage *)resizingImageWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGFloat imgHW = image.size.width * 0.5;
    CGFloat imgHH = image.size.height * 0.5;
    UIImage *resizeImg = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imgHH, imgHW, imgHH-1, imgHW-1) resizingMode:UIImageResizingModeTile];
    return resizeImg;
}

+ (void)setAppBadge:(NSInteger)value {
//    UNNotificationSettings
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = value;
}

+ (void)setNetState {
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

+ (void)openUrl:(NSURL *)url {
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:url options:@{} completionHandler:nil];
}

+ (void)setStatusBar:(UIStatusBarStyle)style {
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarStyle = style;
}

+ (void)setStatusHidden:(BOOL)hidden {
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarHidden = hidden;
}
+ (void)setStatusBarOrientation:(UIInterfaceOrientation)orientation {
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarOrientation = orientation;
}
+ (void)statusBarFrame {
    UIApplication *app = [UIApplication sharedApplication];
    CGRect frame = app.statusBarFrame;
    blog(@"%@", NSStringFromCGRect(frame));
}

+ (BOOL)isNull:(NSString *)s {
    if (s == nil
        || s == NULL
        || [s.lowercaseString isEqualToString:@"null"]
        || [s isEqualToString:@""]
        || s.length == 0
        ) {
        return YES;
    }
    return NO;
}
+ (NSLocale *)locale:(NSString *)loc {
    if ([Tools isNull:loc]) {
        loc = @"zh";
    }
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:loc];
    return locale;
}




@end
