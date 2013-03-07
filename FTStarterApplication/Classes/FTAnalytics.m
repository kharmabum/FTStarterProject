//
//  FTAnalytics.m
//
//  Created by Juan-Carlos Foust on 10/23/12.
//

#import "FTAnalytics.h"
#import "FTApiClient.h"

void uncaughtExceptionHandler(NSException *exception) {
//    [FTAnalytics logError:kFTANALYTICS_CRASH_EVENT message:nil exception:exception];
}

static NSArray *_blackList = nil;

@implementation FTAnalytics

+ (NSArray *)blackList
{
    if (!_blackList) {
        _blackList = @[];
    }
    return _blackList;
}

+ (BOOL)isInternalUsage
{
    if (![[[FTApiClient baseURL] description] isEqualToString:nil]) return YES;
//    if ([[FTAnalytics blackList] containsObject:[FTSessionManager activeUser].email]) return YES;
    return NO;
}

+(void)startTrackingEvents
{
    Mixpanel *sharedInstance = [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    sharedInstance.flushOnBackground = YES;
    sharedInstance.showNetworkActivityIndicator = NO;
    NSSetUncaughtExceptionHandler(uncaughtExceptionHandler);
    [Flurry startSession:FLURRY_API_KEY];
    [Flurry setSessionReportsOnPauseEnabled:YES];
    [Crashlytics startWithAPIKey:CRASHLYTICS_API_KEY];
}

+ (void)logEvent:(NSString* )eventName withParameters:(NSDictionary *)parameters
{   
    if ([FTAnalytics isInternalUsage]) return;
    [[Mixpanel sharedInstance] track:eventName properties:parameters];
    [Flurry logEvent:eventName withParameters:parameters];
}

+ (void)identityUser:(NSString *)userID
{
    [[Mixpanel sharedInstance] identify:userID];
    [[[Mixpanel sharedInstance] people] identify:userID];
}           

+ (void)setUserProperties:(NSDictionary *)params
{
    [[[Mixpanel sharedInstance] people] set:params];
    [[Mixpanel sharedInstance] registerSuperProperties:params];
    if (params[MIXPANEL_USER_PROPERTY_USERNAME]) [[Mixpanel sharedInstance] setNameTag:params[MIXPANEL_USER_PROPERTY_USERNAME]];
}

+(void)logError:(NSString *)err message:(NSString *)message error:(NSError *)errObj
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    if (errObj) params[@"NSError"] = [errObj description];
    if (message) params[@"Message"] = message;
    [Flurry logEvent:err withParameters:params];
    NSLog(@"FTANALYTICS ERROR LOG\n\n %@ \n\n MESSAGE\n\n %@ \n\n DESCRIPTION \n\n %@", err, message, [errObj description]);
}

+(void)logError:(NSString *)err message:(NSString *)message exception:(NSException *)excObj
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    if (excObj) params[@"NSException"] = [excObj description];
    if (message) params[@"Message"] = message;
    NSLog(@"FTANALYTICS EXCEPTION LOG\n\n %@ \n\n MESSAGE\n\n %@ \n\n DESCRIPTION \n\n %@", err, message, [excObj description]);
    [Flurry logEvent:err withParameters:params];
}

+ (void)reset
{
    [[Mixpanel sharedInstance] flush];
    [[Mixpanel sharedInstance] reset];
}

@end
