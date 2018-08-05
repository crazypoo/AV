//
//  AppDelegate.m
//  AV
//
//  Created by 邓杰豪 on 2018/8/4.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "AVCollectionsCollectionViewController.h"
#import "AVVideosCollectionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBarTintColor:AppWhite];
    [[UINavigationBar appearance] setTintColor:AppBlack];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:AppBlack, NSForegroundColorAttributeName, APPFONTBOLD(24), NSFontAttributeName, nil]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *cerSet = [[NSSet alloc]initWithObjects:cerData, nil];
    AFSecurityPolicy *securityPoliy = [AFSecurityPolicy defaultPolicy];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPoliy.allowInvalidCertificates = YES;
    securityPoliy.validatesDomainName = NO;
    //设置证书
    [securityPoliy setPinnedCertificates:cerSet];
    [HTTPClient setSecurityPolicy:securityPoliy];
    
    [self setTabBar];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)setTabBar
{
    CGFloat mainCellW = (kSCREEN_WIDTH-40)/2;
    ViewController *view = [[ViewController alloc] initWithCollectionViewLayout:[CGLayout createLayoutItemW:mainCellW itemH:mainCellW paddingY:10 paddingX:10 scrollDirection:UICollectionViewScrollDirectionVertical]];
    UINavigationController *main = [[UINavigationController alloc] initWithRootViewController:view];
    
    AVCollectionsCollectionViewController *viewCollections = [[AVCollectionsCollectionViewController alloc] initWithCollectionViewLayout:[CGLayout createLayoutItemW:mainCellW itemH:mainCellW paddingY:10 paddingX:10 scrollDirection:UICollectionViewScrollDirectionVertical]];
    UINavigationController *mainCollections = [[UINavigationController alloc] initWithRootViewController:viewCollections];
    
    AVVideosCollectionViewController *viewVideos = [[AVVideosCollectionViewController alloc] initWithCollectionViewLayout:[CGLayout createLayoutItemW:mainCellW itemH:mainCellW paddingY:10 paddingX:10 scrollDirection:UICollectionViewScrollDirectionVertical] withViewShowType:AVViewTypeNormal withKeyWord:@""];
    UINavigationController *mainVideos = [[UINavigationController alloc] initWithRootViewController:viewVideos];

    AVMainTabBarViewController *tabBarController = [[AVMainTabBarViewController alloc] init];
    [tabBarController setViewControllers:@[
                                           main,
                                           mainCollections,
                                           mainVideos
                                           ]];
    self.tabBarController = tabBarController;
}

#pragma mark ------> Delegate
+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
