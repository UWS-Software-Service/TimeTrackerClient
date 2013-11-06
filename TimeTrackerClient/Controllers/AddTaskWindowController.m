//
//  AddTaskWindowController.m
//  TimeTrackerClient
//
//  Created by Marcin Swierczynski on 05.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//

#import "AddTaskWindowController.h"
#import "TimeTrackerRestService.h"

@interface AddTaskWindowController ()

@end

@implementation AddTaskWindowController

- (id)initWithWindowNibName:(NSString *)windowNibName andProjectList:(NSArray *)projects
{
	self = [super initWithWindowNibName:windowNibName];
	if (self) {
		self.projectNames = projects;
	}

	return self;
}


- (id)initWithWindow:(NSWindow *)window
{
	self = [super initWithWindow:window];
	if (self) {
		// Initialization code here.
	}
	return self;
}

- (void)windowDidLoad
{
	[super windowDidLoad];

	[self.projectList addItemsWithTitles:self.projectNames];
}

- (IBAction)addButtonClicked:(id)sender
{
	NSString *projectName = self.projectList.selectedItem.title;
	NSString *task = self.taskField.stringValue;
	if ([task isNotEqualTo:@""]) {
		[[TimeTrackerRestService instance] add:task to:projectName responseHandler:^(BOOL isTaskCreated) {
			if (isTaskCreated) {
				[self.window close];
			} else {
				[self displayErrorFor:projectName];
			}
		}];
	}
}

- (void)displayErrorFor:(NSString *)projectName
{
	NSAlert *alert = [NSAlert alertWithMessageText:@"Error"
	                                 defaultButton:@"OK"
				                   alternateButton:nil
								       otherButton:nil
						 informativeTextWithFormat:@"Cannot add task to project %@. Please, try again.", projectName];
	[alert beginSheetModalForWindow:self.window completionHandler:nil];
}

@end
