//
//  ApiClent
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"


@interface ApiClent : AFHTTPRequestOperationManager

@property NSString *apiKey;

+ (ApiClent *)instance;

- (void)projectsWithResponseHandler:(void (^)(NSDictionary *))success;
- (void)timeSpentTodayWithResponseHandler:(void (^)(NSDictionary *))success;
- (void)logWorkFor:(NSString *)project responseHandler:(void (^)(BOOL))success;

@end