//
//  ConfigService
//
//  Created by Marcin Swierczynski on 01.11.2013.
//  Copyright (c) 2013 UWS. All rights reserved.
//
#import "ConfigService.h"


@implementation ConfigService {

}
+ (ConfigService *)instance {
    static ConfigService *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (void)registerDefaultSettings {
    [[NSUserDefaults standardUserDefaults] registerDefaults:
            [NSDictionary dictionaryWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]]];
}

@end