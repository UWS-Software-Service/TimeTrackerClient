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
			[self setItemImage:projectItem dependingOnProjectState:isProjectActive];

			[self.projectManu addItem:projectItem];
		}
	}];
}

- (void)setItemImage:(NSMenuItem *)projectItem dependingOnProjectState:(BOOL)isProjectActive
{
	if (isProjectActive) {
		projectItem.image = [NSImage imageNamed:NSImageNameStatusUnavailable];
	} else {
		projectItem.image = nil;
	}
}

- (void)projectSelected:(NSMenuItem *)menuItem
{
	NSString *projectName = menuItem.title;
	[[TimeTrackerRestService instance] logWorkFor:projectName responseHandler:^(BOOL isSuccess) {
		if (isSuccess) {
			BOOL isProjectActive = [menuItem.image.name isEqualToString:NSImageNameStatusUnavailable];
			[self setItemImage:menuItem dependingOnProjectState:!isProjectActive];
			[self markAllOtherProjectsAsInactive:projectName];
		} else {
			NSLog(@"Cannot log time for %@", projectName);
		}
	}];
}

- (void)markAllOtherProjectsAsInactive:(NSString *)projectName
{
	for (NSMenuItem *projectItem in [self.projectManu itemArray]) {
		if (![projectItem.title isEqualToString:projectName]) {
			projectItem.image = nil;
		}
	}
}

- (IBAction)settingsMenuClicked:(id)sender
{
	self.settingsController = [[SettingsController alloc] initWithWindowNibName:@"SettingsController"];
	[self.settingsController showWindow:self];
}

@end