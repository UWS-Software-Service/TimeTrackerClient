//
//  ConfigService
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//
#import <Foundation/Foundation.h>

static NSString *const URL_SETTING_KEY = @"URL";
static NSString *const API_KEY_SETTING_KEY = @"ApiKey";

@interface ConfigService : NSObject

+ (ConfigService *)instance;

- (void)registerDefaultSettings;

@end