//
//  MobileRTC.h
//  MobileRTC
//
//  Created by Robust Hu on 8/7/14.
//  Copyright (c) 2016 Zoom Video Communications, Inc. All rights reserved.
//
#import <UIKit/UIKit.h>

//! Project version number for MobileRTC.
FOUNDATION_EXPORT double MobileRTCVersionNumber;

//! Project version string for MobileRTC.
FOUNDATION_EXPORT const unsigned char MobileRTCVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MobileRTC/PublicHeader.h>


#import <Foundation/Foundation.h>

//MobileRTC Constants
#import <MobileRTC/MobileRTCConstants.h>

//MobileRTC AuthService
#import <MobileRTC/MobileRTCAuthService.h>

//MobileRTC MeetingService
#import <MobileRTC/MobileRTCMeetingService.h>
#import <MobileRTC/MobileRTCMeetingService+AppShare.h>
#import <MobileRTC/MobileRTCMeetingService+InMeeting.h>
#import <MobileRTC/MobileRTCMeetingService+Customize.h>

//MobileRTC Meeting Settings
#import <MobileRTC/MobileRTCMeetingSettings.h>

//MobileRTC Invite Helper
#import <MobileRTC/MobileRTCInviteHelper.h>

//MobileRTC Pre-meeting Service
#import <MobileRTC/MobileRTCPremeetingService.h>

//MobileRTC Room Device
#import <MobileRTC/MobileRTCRoomDevice.h>

//MobileRTC Meeting User Info
#import <MobileRTC/MobileRTCMeetingUserInfo.h>


/**
 * The MobileRTC class is a class that exposes an API Rest Client.
 *
 * Access to this class and all other components of the MobileRTC can be granted by including `<MobileRTC/MobileRTC.h>`
 * in your source code.
 *
 * This class provides a class method sharedSDK which provides a preconfigured SDK client,
 * including a MobileRTCMeetingService.
 *
 */
@interface MobileRTC : NSObject
{
    NSString               *_mobileRTCDomain;
    MobileRTCMeetingService  *_meetingService;
    MobileRTCMeetingSettings *_meetingSettings;
    
    MobileRTCAuthService     *_authService;
    MobileRTCPremeetingService *_premeetingService;
}

@property (retain, nonatomic) NSString *mobileRTCDomain;

/**
 * Returns the MobileRTC default client
 *
 * This method is guaranteed to only instantiate one sharedSDK over the lifetime of an app.
 *
 * This client must be configured with your client key and client secret.
 *
 * *Note*: sharedSDK returns a MobileRTC configured with a MobileRTCMeetingService.
 *
 * @return a preconfigured MobileRTC client
 */
+ (MobileRTC*)sharedRTC;

/**
 * Sets the MobileRTC client domain
 *
 * @param domain A domain which used as start/join zoom meeting
 *
 * *Note*: the domain should not include protocol "https" or "http", the format is just like "zoom.us" or "www.zoom.us".
 */
- (void)setMobileRTCDomain:(NSString*)domain;

/**
 * Get the MobileRTC client root navigation controller
 *
 * @return navController, A root navigation controller.
 */
- (UINavigationController*)mobileRTCRootController;

/**
 * Sets the MobileRTC client root navigation controller
 *
 * @param navController A root navigation controller for pushing MobileRTC meeting UI.
 *
 * *Note*: This method is optional, If the window's rootViewController of the app is a UINavigationController, you can call this method, or just ignore it.
 */
- (void)setMobileRTCRootController:(UINavigationController*)navController;

/**
 * Returns the MobileRTC default Auth Service
 *
 * *Note*: Auth Service should be called at first, the MobileRTC can be used after authorizing successfully.
 *
 * @return a preconfigured Auth Service
 */
- (MobileRTCAuthService*)getAuthService;

/**
 * Returns the MobileRTC default Pre-meeting Service
 *
 * *Note*: Pre-meeting Service should be called after signed in with work email, which is used to schedule/eidt/list/delete meeting etc.
 *
 * @return a preconfigured Pre-meeting Service
 */
- (MobileRTCPremeetingService*)getPreMeetingService;

/**
 * Returns the MobileRTC default Meeting Service
 *
 * @return a preconfigured Meeting Service
 */
- (MobileRTCMeetingService*)getMeetingService;

/**
 * Returns the MobileRTC default Meeting Settings
 *
 * @return a object of Meeting Settings
 */
- (MobileRTCMeetingSettings*)getMeetingSettings;

/**
 * To get MobileRTC supported languages
 *
 * @return MobileRTC supported languages array
 */
- (NSArray *)supportedLanguages;

/**
 * Set the MobileRTC language
 *
 * @param lang indicate language type base on MobileRTC supported language.
 *
 * @return YES if success, Otherwise return NO.
 */
- (void)setLanguage:(NSString *)lang;

/**
 * Notify common layer that app will resign active
 */
- (void)appWillResignActive;

/**
 * Notify common layer that app did become active
 */
- (void)appDidBecomeActive;

/**
 * Notify common layer that app did enter backgroud
 */
- (void)appDidEnterBackgroud;

@end
