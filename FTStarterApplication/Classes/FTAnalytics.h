//
//  FTAnalytics.h
//
//  Created by Juan-Carlos Foust on 10/23/12.
//

#ifndef FTANALYTICS
#define FTANALYTICS

#ifndef ANALYTICS_ENABLED
#define ANALYTICS_ENABLED (!DEBUG && !TARGET_IPHONE_SIMULATOR)
#endif

#if !TARGET_IPHONE_SIMULATOR
#define PRODUCTION_MODE 1
#endif

#import "Mixpanel.h"
#import "Flurry.h"

#define FLURRY_API_KEY                                              @""
#define MIXPANEL_TOKEN                                              @""
#define CRASHLYTICS_API_KEY                                         @""

#define MIXPANEL_USER_PROPERTY_EMAIL                                @"$email"
#define MIXPANEL_USER_PROPERTY_FIRST_NAME                           @"$first_name"
#define MIXPANEL_USER_PROPERTY_USERNAME                             @"$username"
#define MIXPANEL_USER_PROPERTY_IOS_DEVICES                          @"$ios_devices"

@interface FTAnalytics : NSObject

+ (void)startTrackingEvents;
+ (void)logEvent:(NSString*)eventName withParameters:(NSDictionary *)parameters;

+ (void)identityUser:(NSString *)userID;
+ (void)setUserProperties:(NSDictionary *)params;

+ (void)logError:(NSString *)err message:(NSString *)mssg error:(NSError *)errObj;
+ (void)logError:(NSString *)err message:(NSString *)mssg exception:(NSException *)excObj;

+ (void)reset;

@end

#endif
