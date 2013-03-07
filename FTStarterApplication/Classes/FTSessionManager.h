//
//  FTSessionManager.h
//
//  Created by Juan-Carlos Foust on 7/2/12.
//

#ifndef FTSESSIONMANAGER
#define FTSESSIONMANAGER

#import <Foundation/Foundation.h>
//#import <FacebookSDK/FacebookSDK.h>

@class FTUser, CLLocation;

@interface FTSessionManager : NSObject
    
+ (void)suspendSession;
+ (void)resumeSession;

//+ (FTSessionManager *)sharedManager;
//+ (FTUser *)activeUser;
//+ (FBSession *)facebookSession;
//
//+ (void)loginWithFacebookWithCompletionHandler:(void(^)(NSString *status))block;
//+ (void)userAuthorizedWithCredentials:(NSDictionary *)userInfo;
//+ (void)logOut;
//+ (void)showSignUpViewController;

/* Location and Recommendation Site Management */
+ (CLLocation *)location;
+ (void)setDestination:(CLLocation *)destination;

+ (void)tryLocationUpdate;
+ (void)updateLocation;
+ (void)mapDidUpdateUserLocation:(CLLocation *)userLocation;

@end

#endif
