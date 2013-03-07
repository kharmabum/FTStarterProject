//
//  HPApiClient.m
//  Activities
//
//  Created by Juan-Carlos Foust on 8/21/12.
//  Copyright (c) 2012 Juan-Carlos Foust. All rights reserved.
//

#import "FTApiClient.h"
#import "FTAnalytics.h"

@implementation FTApiClient

+ (NSURL *)baseURL
{
    return [NSURL URLWithString:API_BASEURL];
}

+ (id)sharedInstance {
    static FTApiClient *__sharedInstance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        __sharedInstance = [[FTApiClient alloc] initWithBaseURL:
                            [NSURL URLWithString:API_BASEURL]];
    });
    return __sharedInstance;
}

+ (void)sendJSONRequestWithRequest:(NSURLRequest *)request success:(FTApiSuccessBlock)success failure:(FTApiFailureBlock)failure
{
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
                                             if ([[json valueForKey:@"status"] isEqualToString:@"OK"]) {
                                                 if (success) success([json valueForKey:@"results"]);
                                             } else {
                                                 if (failure) failure([json valueForKeyPath:@"status"], json);
                                                 [FTAnalytics logError:[json valueForKeyPath:@"status"] message:[json description] error:nil];
                                             }
                                         } failure:^( NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id json ) {
//                                             [FTAnalytics logError:HPANALYTICS_NETWORK_ERROR message:[request description] error:error];
//                                             if (failure) failure(HPANALYTICS_NETWORK_ERROR, json);
                                         }];
    
    [[[self sharedInstance] operationQueue] addOperation:operation];
}

#pragma mark - User

+ (void)createUserWithUsername:(NSString *)username email:(NSString *)email password:(NSString *)password fbid:(NSString *)fbid fbaccesstoken:(NSString*)token success:(FTApiSuccessBlock)success failure:(FTApiFailureBlock)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    if (email) params[@"email"] = email;
    if (username) params[@"name"] = username;
    if (fbid) params[@"fbid"] = fbid;
    if (password) params[@"password"] = password;
    if (token) params[@"fb_token"]=token;
    NSURLRequest *request = [[self sharedInstance] requestWithMethod:@"POST" path:nil parameters:params];
    [FTApiClient sendJSONRequestWithRequest:request success:success failure:failure];
}


#pragma mark - Photos

+ (void)pushPhoto:(UIImage*)image success:(FTApiSuccessBlock)success failure:(FTApiFailureBlock)failure
{
    [[FTApiClient sharedInstance] performBlockInBackground:^{
        NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);
        [[FTApiClient sharedInstance] performBlockOnMainThread:^{
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
//            if (activity) params[@"hopp_id"] = activity;
//            if (user) params[@"user"] = user;
            NSMutableURLRequest *request = [[self sharedInstance] multipartFormRequestWithMethod:@"POST"
                                                                                            path:nil //kAPICAll
                                                                                      parameters:params
                                                                       constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                                                                           [formData appendPartWithFileData:imageData
                                                                                                       name:@"file"
                                                                                                   fileName:@"photoUpload"
                                                                                                   mimeType:@"image/jpeg"];}];
            [FTApiClient sendJSONRequestWithRequest:request success:success failure:failure];
        }];
    }];
}

@end
