//
//  FTDefines.h
//  FTStarterApplication
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#ifndef FTDEFINES
#define FTDEFINES

#import <Foundation/Foundation.h>
#import "NSObject+PerformBlock.h"
#import "NSObject+SBJSON.h"
#import "NSString+UUID.h"
#import "NSArray+Accessing.h"
#import "FTNullOrEmpty.h"

@interface FTDefines : NSObject

#pragma mark - API

//extern NSString *const kCDIAPIClientID;
//extern NSString *const kCDIAPIClientSecret;

#pragma mark - Fonts

extern NSString *const kFTRegularFontName;
extern NSString *const kFTBoldFontName;
extern NSString *const kFTBoldItalicFontName;
extern NSString *const kFTItalicFontName;

#pragma mark - Notifications

extern NSString *const kFTGenericNotification;

#pragma mark - Analytics

extern NSString *const kFTGenericEvent;
extern NSString *const kFTGenericEventParam;

@end

#endif