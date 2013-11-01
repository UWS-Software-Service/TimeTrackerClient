//
//  AppDelegate.m
//  TimeTrackerClient
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigService.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[ConfigService instance] registerDefaultSettings];
}

@end