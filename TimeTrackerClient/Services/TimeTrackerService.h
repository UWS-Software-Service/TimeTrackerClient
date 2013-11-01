//
//  TimeTrackerService
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol TimeTrackerService <NSObject>

- (void)projects:(void (^)(NSArray *))block;

- (void)timeSpentToday:(void (^)(double))block;

- (void)logWorkFor:(NSString *)project responseHandler:(void (^)(BOOL))block;

@end