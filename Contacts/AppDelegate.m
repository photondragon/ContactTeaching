//
//  AppDelegate.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "AppDelegate.h"
#import "ContactInfoController.h"
#import "ContactsController.h"
#import "MyModels.h"
#import "IDNFoundation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	NSLog(@"%@", [NSString documentsPath]);

	CGRect rect = [UIScreen mainScreen].bounds;
	self.window = [[UIWindow alloc] initWithFrame:rect];
	self.window.backgroundColor = [UIColor whiteColor];

//	ContactInfo* contact = [[ContactInfo alloc] init];
//	contact.name = @"zhangsan";
//	contact.phone = @"18812340001";
//	ContactInfoController* contactInfoController = [[ContactInfoController alloc] init];
//	contactInfoController.contact = contact;
//	contactInfoController.title = @"联系人信息";
//	contactInfoController.view.backgroundColor = [UIColor whiteColor];

	ContactsController* contactsController = [[ContactsController alloc] init];
	contactsController.title = @"联系人";

	UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:contactsController];

	self.window.rootViewController = nav;

	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[MyModels save];
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

@end
