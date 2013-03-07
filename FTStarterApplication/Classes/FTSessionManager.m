//
//  FTSessionManager.m
//  OneHundredPlus
//
//  Created by Juan-Carlos Foust on 7/2/12.
//  Copyright (c) 2012 100Plus. All rights reserved.
//

#import "FTSessionManager.h"
#import "FTApiClient.h"
//#import "HPUser.h"
//#import "HPViewDeckController.h"

//#define THRESHOLD_DISTANCE              70
//#define ONE_MILE_IN_METERS              1609.34
//#define SIGNIFICANT_LOCATION_CHANGE     ONE_MILE_IN_METERS/4
//#define HALF_HOUR_IN_SECONDS            60*30
#define UPDATE_FREQUENCY                5*60

@interface FTSessionManager () <CLLocationManagerDelegate>
//@property (strong, nonatomic)   HPUser *activeUser;
//@property (strong, nonatomic)   FBSession *facebookSession;
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

//- (HPUser *)activeUser
//{
//    if (!_activeUser) {
//        NSData *savedUser = [[NSUserDefaults standardUserDefaults] objectForKey:ACTIVE_USER_ID];
//        if (![savedUser isKindOfClass:[NSData class]]) return nil; //OLD VERSION OF APP - FORCE LOGIN
//        _activeUser = (HPUser *)[NSKeyedUnarchiver unarchiveObjectWithData:savedUser];
//    }
//    return _activeUser;
//}

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

//+ (HPUser *)activeUser
//{    
//    return [FTSessionManager sharedManager].activeUser;
//}
//
//+ (FBSession *)facebookSession
//{
//    return [self sharedManager].facebookSession;
//}

+ (CLLocation *)location
{
    return [FTSessionManager sharedManager].location;
}

+ (void)setDestination:(CLLocation *)destination
{
    [FTSessionManager sharedManager].destination = destination;
}


#pragma mark - Facebook Session Management

//
//+ (void)loginWithFacebookWithCompletionHandler:(void(^)(NSString *status))block;
//{
//    if ([FTSessionManager facebookSession].state != FBSessionStateCreated) [FTSessionManager sharedManager].facebookSession = [[FBSession alloc] initWithPermissions:@[@"email"]];
//  
//    [[FTSessionManager facebookSession] openWithCompletionHandler:^(FBSession *session,
//                                                                    FBSessionState status,
//                                                                    NSError *error) {
//      switch (status) {
//        case FBSessionStateOpen: {
//          [self sharedManager].facebookSession = session;
//          if ([FTSessionManager facebookSession].isOpen) {
//            [[[FBRequest alloc] initWithSession:[FTSessionManager facebookSession] graphPath:@"me"]startWithCompletionHandler:
//             ^(FBRequestConnection *connection,
//               NSDictionary<FBGraphUser> *user,
//               NSError *error) {
//               NSString *username = user.name;
//               NSString *fbid = user.id;
//               NSString *email = user[@"email"];
//                 NSString *fbtoken = [FTSessionManager facebookSession].accessTokenData.accessToken;
//               
//                  /* Connection Request Success */
//               if (!error) {
//                   [HPApiClient createUserWithUsername:username email:email password:nil fbid:fbid fbaccesstoken:fbtoken success:^(NSDictionary *results) {
//                     NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ACTIVE_USER_ID : results[ACTIVE_USER_ID]}];
//                     if (email) params[@"email"] = email;
//                     if (username) params[@"username"] = username;
//                     if (results[@"thrive_score"]) params[@"thrive_score"] = results[@"thrive_score"];
//                     if (results[@"groups"]) params[@"groups"] = results[@"groups"];
//                    [FTSessionManager userAuthorizedWithCredentials:params];
//                    block(@"OK");
//                    return;
//                     
//                     /* HPAccountCreation Request Error */
//                 } failure:^(NSString *status, id json) {
//                     NSString *message = @"Facebook Failure on HPAccountCreation";
//                     block(HPANALYTICS_FACEBOOK_ERROR);
//                     [HPAnalytics logError:HPANALYTICS_FACEBOOK_ERROR message:message error:error];
//                 }];
//            
//                   /* Connection Request Error */
//               } else {
//                   NSString *message = @"Facebook Failure on error returned from Connection Request";
//                   block(HPANALYTICS_FACEBOOK_ERROR);
//                   [HPAnalytics logError:HPANALYTICS_FACEBOOK_ERROR message:message error:error];
//                }
//             }];
//          }
//        }
//          break;
//          
//          /* Succesful Logout */
//        case FBSessionStateClosed:
//          {
//              break;
//          }
//        
//        /*Facebook Session failure on open - Completion Handler*/
//        case FBSessionStateClosedLoginFailed:
//          {
//            [FBSession.activeSession closeAndClearTokenInformation];
//            NSString *message = @"Facebook Failure on Open - Completion Handler";
//            block(HPANALYTICS_FACEBOOK_ERROR);
//            [FTAnalytics logError:HPANALYTICS_FACEBOOK_ERROR message:message error:error];
//            break;
//          }
//        default:
//          break;
//      }
//    }];
//}


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
    // Facebook 
//    if (![FTSessionManager facebookSession].isOpen) {
//        [HPAnalytics logEvent:@"Facebook session closed on resume" withParameters:nil];
//        [FTSessionManager sharedManager].facebookSession = [[FBSession alloc] initWithPermissions:@[@"email"]];
//        if ([FTSessionManager facebookSession].state == FBSessionStateCreatedTokenLoaded) {
//            [[FTSessionManager facebookSession] openWithCompletionHandler:^(FBSession *session,
//                                                                            FBSessionState status,
//                                                                            NSError *error) {
//                switch (status) {
//                    case FBSessionStateOpen: {
//                        [self sharedManager].facebookSession = session;
//                        if ([FTSessionManager facebookSession].isOpen) {
//                            [[[FBRequest alloc] initWithSession:[FTSessionManager facebookSession] graphPath:@"me"]startWithCompletionHandler:
//                             ^(FBRequestConnection *connection,
//                               NSDictionary<FBGraphUser> *user,
//                               NSError *error) {                                 
//                                 /*Connection Request Success*/
//                                 if (!error) {
//                                     NSLog(@"FTSessionManager - ResumeSession - Facebook success");
//                                     /*Connection Request Error*/
//                                 } else {
//                                     NSString *message = @"Facebook Failure on error returned from Connection Request";
//                                     [HPAnalytics logError:HPANALYTICS_FACEBOOK_ERROR message:message error:error];
//                                 }
//                             }];
//                        }
//                    }
//                        break;
//                    case FBSessionStateClosed:
//                        break;
//                    /*Facebook Session failure on open - Completion Handler*/
//                    case FBSessionStateClosedLoginFailed:
//                    {
//                        [FBSession.activeSession closeAndClearTokenInformation];
//                        NSString *message = @"Facebook Failure on Open - Completion Handler";
//                        [HPAnalytics logError:HPANALYTICS_FACEBOOK_ERROR message:message error:error];
//                        break;
//                    }
//                    default:
//                        break;
//                }
//            }];
//        }
//    }
//    
//    [FTSessionManager tryLocationUpdate];
//    if ([FTSessionManager activeUser]) {
//        // FIXME: Potential bug with invalidated session token and popping the SignUpVC before rootViewController is loaded
//        [HPApiClient onApplicationResume];
//        [HPApiClient getCurrentLifeScore:^(NSDictionary *results) {
//            if (results[@"thrive_score"]) {
//                [FTSessionManager updateThriveScore: results[@"thrive_score"] animated:NO];
//            }
//        } failure:^(NSString *status, id json) {
//            NSLog(@"\n\nFTSessionManager - Lifescore failed to return from server - w/ status : %@ \n\n and JSON - %@", status, json);
//        }];
//       [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NOTIFICATION_SESSION_DID_RESUME object:nil]];
//    }
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
