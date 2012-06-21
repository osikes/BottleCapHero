//
//  AppDelegate.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/20/12.
//  Copyright University of Alabama Athletics 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
