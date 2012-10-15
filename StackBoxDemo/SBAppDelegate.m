//
//  SBAppDelegate.m
//  StackBoxDemo
//
//  Created by Torin on 11/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import "SBAppDelegate.h"

#import "SBViewController.h"

@implementation SBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 
  BOOL isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
  NSString *nibName = isPad ? @"SBViewController~ipad" : @"SBViewController";
  
  self.viewController = [[SBViewController alloc] initWithNibName:nibName bundle:nil];
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
