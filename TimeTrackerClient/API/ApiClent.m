//
//  ApiClent
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2012 UWS. All rights reserved.
//
#import "ApiClent.h"
#import "ConfigService.h"


static NSString *const ENDPOINT = @"timeLog";
static NSString *const PROJECTS_ENDPOINT = @"projects";
static NSString *const TIME_SPENT_ENDPOINT = @"timeSpentToday";
static NSString *const LOG_WORK_ENDPOINT = @"log";

@implementation ApiClent {

@private
	NSString *_apiKey;
}
@synthesize apiKey = _apiKey;

+ (ApiClent *)instance
{
	static ApiClent *_instance = nil;

	@synchronized (self) {
		if (_instance == nil) {
			_instance = [[self alloc] initWithBaseURL];
		}
	}

	return _instance;
}

- (id)initWithBaseURL
{
	NSString *url = [[NSUserDefaults standardUserDefaults] stringForKey:URL_SETTING_KEY];
	self = [super initWithBaseURL:[[NSURL alloc] initWithString:url]];
	if (self) {
		NSString *apiKey = [[NSUserDefaults standardUserDefaults] stringForKey:API_KEY_SETTING_KEY];
		self.apiKey = apiKey;
	}
	return self;
}

- (void)projectsWithResponseHandler:(void (^)(NSDictionary *))success
{
	[[ApiClent instance] POST:[self endpointTo:PROJECTS_ENDPOINT] parameters:[self createParams]
	                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
		                  success(responseObject);
	                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"%@", error);
	}];
}

- (void)timeSpentTodayWithResponseHandler:(void (^)(NSDictionary *))success
{
	[[ApiClent instance] POST:[self endpointTo:TIME_SPENT_ENDPOINT] parameters:[self createParams]
	                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
		                  success(responseObject);
	                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"%@", error);
	}];
}

- (void)logWorkFor:(NSString *)project responseHandler:(void (^)(BOOL))success
{
	NSMutableDictionary *parameters = [self createParams];
	[parameters setValue:project forKey:@"name"];

	[[ApiClent instance] POST:[self endpointTo:LOG_WORK_ENDPOINT] parameters:parameters
	                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
		                  [operation.response statusCode] == 201 ? success(YES) : success(NO);
	                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"%@", error);
		success(NO);
	}];
}

- (NSString *)endpointTo:(NSString *)endpoint
{
	return [NSString stringWithFormat:@"%@/%@", ENDPOINT, endpoint];
}

- (NSMutableDictionary *)createParams
{
	return @{
			@"apiToken" : self.apiKey
	}.mutableCopy;
}


@end