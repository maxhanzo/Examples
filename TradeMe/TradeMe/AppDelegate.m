//
//  AppDelegate.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "ListingsTableViewController.h"
#import "CategoriesTableViewController.h"

//TODO: Move this to a config file
#define DB_NAME @"TradeMe.db"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Move DB file to ../Documents/
    [self checkAndCreateDatabase];

    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    
    //Important: preventing Master ViewController from appearing on top of Details View Controller
    //when iPads are in Portrait Orientation Mode.
    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    UINavigationController *leftNavController = [splitViewController.viewControllers objectAtIndex:0];
    CategoriesTableViewController *leftViewController = (CategoriesTableViewController *)[leftNavController topViewController];
    UINavigationController *rightNavController = [splitViewController.viewControllers objectAtIndex:1];
    ListingsTableViewController *rightViewController = (ListingsTableViewController*)[rightNavController topViewController];
    
    leftViewController.delegate = rightViewController;
    
    [rightViewController.navigationItem setLeftItemsSupplementBackButton: YES];
    [rightViewController.navigationItem setLeftBarButtonItem:splitViewController.displayModeButtonItem];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Database stuff
//Retrieving home directory
-(NSString *)GetDocumentDirectory{
    self.fileMgr = [NSFileManager defaultManager];
    self.homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return self.homeDir;
}

//Moving database file to ../Documents/ (thus, the db file can be read and written
-(void) checkAndCreateDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *databasePath = [self.GetDocumentDirectory stringByAppendingPathComponent:DB_NAME];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) {
        NSLog(@"Database file successfully moved.");
        return;}
    else{
        NSLog(@"Unable to move database file.");
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    }
}
@end
