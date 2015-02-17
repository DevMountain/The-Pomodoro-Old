//
//  POAppearanceController.m
//  The Pomodoro
//
//  Created by Caleb Hicks on 2/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POAppearanceController.h"

@implementation POAppearanceController

+ (void)initializeAppearanceDefaults {
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size:20]
                                                           }];

}

@end
