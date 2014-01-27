//
//  FTSessionManager.m
//  OneHundredPlus
//
//  Created by Juan-Carlos Foust on 7/2/12.
//  Copyright (c) 2012 100Plus. All rights reserved.
//

#import "FTSessionManager.h"
#import "FTApiClient.h"

#define THRESHOLD_DISTANCE              70
#define ONE_MILE_IN_METERS              1609.34
#define SIGNIFICANT_LOCATION_CHANGE     ONE_MILE_IN_METERS/4
#define HALF_HOUR_IN_SECONDS            60*30
#define UPDATE_FREQUENCY                5*60

@interface FTSessionManager () <CLLocationManagerDelegate>
@property (strong, nonatomic)   CLLocation *location;
@property (strong, nonatomic)   CLLocation *destination;
@property (strong, nonatomic)   CLLocationManager *locationManager;
@property (strong, nonatomic)   NSTimer *locationTimer;
@end

@implementation FTSessionManager

#pragma mark - CLLocationManagerDelegation

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    BOOL significantLocationChange = (!self.location || [newLocation distanceFromLocation:self.location] > (SIGNIFICANT_LOCATION_CHANGE));
    self.location = newLocation;
    [self.locationManager stopUpdatingLocation];
//    if ([FTSessionManager activeUser] && significantLocationChange) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SIGNIFICANT_LOCATION_UPDATE object:nil];
//    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{}
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{}

# pragma mark - Instance Methods

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    return _locationManager;
}

- (id)init
{
    if (self = [super init])
    {
        self.destination = nil;
    }
    return self;
}

# pragma mark - Class Functions

+ (FTSessionManager *)sharedManager
{
    static dispatch_once_t pred = 0;
    __strong static FTSessionManager *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

+ (CLLocation *)location
{
    return [FTSessionManager sharedManager].location;
}

+ (void)setDestination:(CLLocation *)destination
{
    [FTSessionManager sharedManager].destination = destination;
}


#pragma mark - Facebook Session Management



#pragma mark - Session Managment

//+ (void)showSignUpViewController
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    HPSignUpVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"HPSignUpVC"];
//    vc.delegate = [UIApplication sharedApplication].keyWindow.rootViewController;
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:NULL];
//}

+ (void)suspendSession
{
    // TODO: released resources, serialization data, reset ivars for return.
    FTSessionManager *sharedManager = [FTSessionManager sharedManager];
    [sharedManager.locationTimer invalidate];
    [sharedManager setLocationTimer:nil];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:sharedManager.activeUser] forKey:ACTIVE_USER_ID];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NOTIFICATION_SESSION_DID_SUSPEND object:nil]];
}

+ (void)resumeSession
{

}

+ (void)userAuthorizedWithCredentials:(NSDictionary *)userInfo
{
//    HPUser *user = [HPUser userWithInfo:userInfo];
//    [[FTSessionManager sharedManager] setActiveUser:user];
//    [FTSessionManager setPreferredRecommendationSite:SETTINGS_RECOMMENDATION_SITE_CURRENT_LOCATION];
//    [FTSessionManager tryLocationUpdate];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:user] forKey:ACTIVE_USER_ID];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    if (userInfo[@"email"]) [HPAnalytics setUserProperties:@{MIXPANEL_USER_PROPERTY_EMAIL : userInfo[@"email"]}];
//    if (userInfo[@"username"]) [HPAnalytics setUserProperties:@{MIXPANEL_USER_PROPERTY_USERNAME : userInfo[@"username"]}];
//    [HPAnalytics identityUser:userInfo[ACTIVE_USER_ID]];
//    [HPAnalytics logEvent:HPANALYTICS_EVENT_LOGIN withParameters:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NOTIFICATION_SESSION_DID_RESUME object:nil]];
}

+ (void)logOut
{
//    [HPApiClient logOutUserWithSuccess:NULL failure:NULL];
//    [[FTSessionManager facebookSession] closeAndClearTokenInformation];
//    [[FTSessionManager sharedManager] setActiveUser:nil];
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//    [HPAnalytics logEvent:HPANALYTICS_EVENT_LOGOUT withParameters:nil];
//    [HPAnalytics reset];
//    [FTSessionManager showSignUpViewController];
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NOTIFICATION_LOG_OUT object:nil]];

}

#pragma mark - Location Managment

+ (void)tryLocationUpdate
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        [FTSessionManager updateLocation];
    } 
}

+ (void)updateLocation
{
//    if (![FTSessionManager activeUser]) return;
    FTSessionManager *sharedManager = [FTSessionManager sharedManager];
    [sharedManager.locationManager stopUpdatingLocation];
    [sharedManager.locationManager startUpdatingLocation];
    [sharedManager.locationTimer invalidate];
    [sharedManager setLocationTimer:nil];
    [sharedManager setLocationTimer:[NSTimer timerWithTimeInterval:UPDATE_FREQUENCY target:[FTSessionManager class] selector:@selector(updateLocation) userInfo:nil repeats:NO]];
}

+ (void)mapDidUpdateUserLocation:(CLLocation *)userLocation
{
    FTSessionManager *sharedManager = [FTSessionManager sharedManager];
    sharedManager.location = userLocation;
    [sharedManager.locationTimer invalidate];
    [sharedManager setLocationTimer:nil];
    [sharedManager setLocationTimer:[NSTimer timerWithTimeInterval:UPDATE_FREQUENCY target:[FTSessionManager class] selector:@selector(updateLocation) userInfo:nil repeats:NO]];
}



@end
