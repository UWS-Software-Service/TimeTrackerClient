//
//  TimeTrackerRestService
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//
#import "TimeTrackerRestService.h"
#import "ApiClent.h"


@implementation TimeTrackerRestService {

}

+ (TimeTrackerRestService *)instance
{
	static TimeTrackerRestService *_instance = nil;

	@synchronized (self) {
		if (_instance == nil) {
			_instance = [[self alloc] init];
		}
	}

	return _instance;
}

- (void)projects:(void (^)(NSDictionary *))block
{
	[[ApiClent instance] projectsWithResponseHandler:^(NSDictionary *dictionary) {
		block([dictionary objectForKey:@"projects"]);
	}];
}

- (void)timeSpentToday:(void (^)(double))block
{
	[[ApiClent instance] timeSpentTodayWithResponseHandler:^(NSDictionary *dictionary) {
		block([[dictionary objectForKey:@"timeSpentToday"] doubleValue]);
	}];
}

- (void)logWorkFor:(NSString *)project responseHandler:(void (^)(BOOL))block
{
	[[ApiClent instance] logWorkFor:project responseHandler:^(BOOL isSuccess) {
		block(isSuccess);
	}];
}

- (void)add:(NSString *)task to:(NSString *)project responseHandler:(void (^)(BOOL))block
{
	[[ApiClent instance] add:task to:project responseHandler:^(BOOL isSuccess) {
		block(isSuccess);
	}];
}


@end