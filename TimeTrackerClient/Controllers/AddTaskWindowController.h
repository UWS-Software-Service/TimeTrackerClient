//
//  AddTaskWindowController.h
//  TimeTrackerClient
//
//  Created by Marcin Swierczynski on 05.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AddTaskWindowController : NSWindowController

@property(assign) IBOutlet NSPopUpButton *projectList;
@property(assign) IBOutlet NSTextField *taskField;
@property(strong) NSDictionary *projects;

- (id)initWithWindowNibName:(NSString *)windowNibName andProjects:(NSDictionary *)projects;
@end
