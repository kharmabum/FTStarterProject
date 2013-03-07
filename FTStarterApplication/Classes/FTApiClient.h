//
//  FTApiClient.h
//  Created by Juan-Carlos Foust on 8/21/12.
//

#ifndef FTAPICLIENT
#define FTAPICLIENT

#import "AFNetworking.h"

//~~~~~~~~~ Networking ~~~~~~~~~~~//

#ifdef DEBUG
#define API_BASEURL                                             @""
#else
#define API_BASEURL                                             @""
#endif

typedef void(^FTApiSuccessBlock)(NSDictionary *results);
typedef void(^FTApiFailureBlock)(NSString *status, id json);

@interface FTApiClient : AFHTTPClient

+ (NSURL *)baseURL;
+ (id)sharedInstance;

/* User */

+ (void)createUserWithUsername:(NSString *)username email:(NSString *)email password:(NSString *)password fbid:(NSString *)fbid fbaccesstoken:(NSString*)token success:(FTApiSuccessBlock)success failure:(FTApiFailureBlock)failure;

/* Photos */

+ (void)pushPhoto:(UIImage*)photo success:(FTApiSuccessBlock)success failure:(FTApiFailureBlock)failure;


@end

#endif
