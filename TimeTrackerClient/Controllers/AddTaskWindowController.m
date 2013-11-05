//
//  AddTaskWindowController.m
//  TimeTrackerClient
//
//  Created by Marcin Swierczynski on 05.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//

#import "AddTaskWindowController.h"

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
		NSLog(@"Add '%@' for %@", task, projectName);
	}
}

@end
