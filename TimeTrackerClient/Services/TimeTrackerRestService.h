//
//  TimeTrackerRestService
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "TimeTrackerService.h"


@interface TimeTrackerRestService : NSObject<TimeTrackerService>

+ (TimeTrackerRestService *)instance;

@end