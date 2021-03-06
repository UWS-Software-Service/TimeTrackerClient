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
#import "SettingsWindowController.h"
#import "AddTaskWindowController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[[ConfigService instance] registerDefaultSettings];
	[self configureStatusItem];
	[self loadProjects];
	[self updateCurrentDayTimeLog];
}

- (void)configureStatusItem
{
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	self.statusItem.highlightMode = YES;
	self.statusItem.menu = self.menu;
	self.statusItem.title = @"0.0";
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

- (void)updateCurrentDayTimeLog
{
	[[TimeTrackerRestService instance] timeSpentToday:^(double timeSpentToday) {
		self.statusItem.title = [NSString stringWithFormat:@"%.1f", timeSpentToday];
	}];
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

		[self updateCurrentDayTimeLog];
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

- (void)setItemImage:(NSMenuItem *)projectItem dependingOnProjectState:(BOOL)isProjectActive
{
	if (isProjectActive) {
		projectItem.image = [NSImage imageNamed:NSImageNameStatusUnavailable];
	} else {
		projectItem.image = nil;
	}
}

- (IBAction)settingsMenuClicked:(id)sender
{
	self.settingsController = [[SettingsWindowController alloc] initWithWindowNibName:@"SettingsWindowController"];
	[self.settingsController showWindow:self];
}

- (IBAction)addTaskMenuClicked:(id)sender
{
	self.addTaskWindowController = [[AddTaskWindowController alloc] initWithWindowNibName:@"AddTaskWindowController"
	                                                                          andProjects:[self projectsWithState]];
	[self.addTaskWindowController showWindow:self];
}

- (NSDictionary *)projectsWithState
{
	NSMutableDictionary *projectsWithState = [NSMutableDictionary dictionary];
	for (NSMenuItem *projectItem in self.projectManu.itemArray) {
		BOOL isProjectActive = [projectItem.image.name isEqualToString:NSImageNameStatusUnavailable];
		[projectsWithState setObject:[NSNumber numberWithBool:isProjectActive] forKey:projectItem.title];
	}
	return projectsWithState;
}

@end