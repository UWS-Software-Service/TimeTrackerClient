//
//  AppDelegate.h
//  TimeTrackerClient
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SettingsController;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property(assign) IBOutlet NSMenu *menu;
@property(assign) IBOutlet NSMenu *projectManu;
@property(strong) NSStatusItem *statusItem;
@property(strong) SettingsController *settingsController;

@end