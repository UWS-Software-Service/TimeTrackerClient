//
//  AppDelegate.m
//  TimeTrackerClient
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigService.h"
#import "TimeTrackerRestService.h"
#import "SettingsController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[[ConfigService instance] registerDefaultSettings];
	[self configureStatusItem];
	[self loadProjects];
}

- (void)configureStatusItem
{
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	self.statusItem.highlightMode = YES;
	self.statusItem.menu = self.menu;
	self.statusItem.title = @"TT";
}

- (void)loadProjects
{
	[[TimeTrackerRestService instance] projects:^(NSDictionary *projects) {
		for (NSString *project in projects) {
			NSMenuItem *projectItem = [[NSMenuItem alloc] initWithTitle:project
			                                                     action:@selector(projectSelected:)
				                                          keyEquivalent:@""];

			BOOL isProjectActive = [[projects objectForKey:project] boolValue];
			if (isProjectActive) {
				projectItem.image = [NSImage imageNamed:NSImageNameStatusUnavailable];
			} else {
				projectItem.image = nil;
			}

			[self.projectManu addItem:projectItem];
		}
	}];
}

- (void)projectSelected:(NSMenuItem *)menuItem
{
	NSString *projectName = menuItem.title;
	[[TimeTrackerRestService instance] logWorkFor:projectName responseHandler:^(BOOL isSuccess) {
		if (isSuccess) {
			if ([menuItem.image.name isEqualToString:NSImageNameStatusUnavailable]) {
				menuItem.image = nil;
			} else {
				menuItem.image = [NSImage imageNamed:NSImageNameStatusUnavailable];
			}
		} else {
			NSLog(@"Cannot log time for %@", projectName);
		}
	}];
}

- (IBAction)settingsMenuClicked:(id)sender
{
	self.settingsController = [[SettingsController alloc] initWithWindowNibName:@"SettingsController"];
	[self.settingsController showWindow:self];
}

@end