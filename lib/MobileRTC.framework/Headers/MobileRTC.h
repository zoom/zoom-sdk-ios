//
//  MobileRTC.h
//  MobileRTC
//
//  Created by Robust Hu on 8/7/14.
//  Copyright (c) 2016 Zoom Video Communications, Inc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MobileRTC/MobileRTCConstants.h>
#import <MobileRTC/MobileRTCAuthService.h>
#import <MobileRTC/MobileRTCMeetingService.h>
#import <MobileRTC/MobileRTCMeetingService+AppShare.h>
#import <MobileRTC/MobileRTCMeetingService+InMeeting.h>
#import <MobileRTC/MobileRTCMeetingService+Customize.h>
#import <MobileRTC/MobileRTCMeetingService+Audio.h>
#import <MobileRTC/MobileRTCMeetingService+Video.h>
#import <MobileRTC/MobileRTCMeetingService+User.h>
#import <MobileRTC/MobileRTCMeetingService+Chat.h>
#import <MobileRTC/MobileRTCMeetingService+Webinar.h>
#import <MobileRTC/MobileRTCMeetingSettings.h>
#import <MobileRTC/MobileRTCInviteHelper.h>
#import <MobileRTC/MobileRTCPremeetingService.h>
#import <MobileRTC/MobileRTCRoomDevice.h>
#import <MobileRTC/MobileRTCMeetingUserInfo.h>
#import <MobileRTC/MobileRTCMeetingChat.h>
#import <MobileRTC/MobileRTCE2EMeetingKey.h>
#import <MobileRTC/MobileRTCMeetingDelegate.h>
#import <MobileRTC/MobileRTCVideoView.h>
#import <MobileRTC/MobileRTCMeetingActionItem.h>
#import <MobileRTC/MobileRTCAnnotationService.h>
#import <MobileRTC/MobileRTCRemoteControlService.h>
/*!
 @class MobileRTC
 @brief MobileRTC class is a class that exposes an API Rest Client.
 @discussion Access to this class and all other components of the MobileRTC can be granted by including <MobileRTC/MobileRTC.h> in your source code.
 @warning This class provides a class method sharedSDK which provides a preconfigured SDK client.
 */
@interface MobileRTC : NSObject
{
    NSString               *_mobileRTCDomain;
    NSString               *_mobileRTCResPath;
    MobileRTCMeetingService  *_meetingService;
    MobileRTCMeetingSettings *_meetingSettings;
    
    MobileRTCAuthService     *_authService;
    MobileRTCPremeetingService *_premeetingService;
    
    MobileRTCAnnotationService *_annotationService;
    
    MobileRTCRemoteControlService *_remoteControlService;
}

/*!
 @brief This property knows as the MobileRTC domain, which is readonly for external.
 */
@property (retain, nonatomic, readonly) NSString *mobileRTCDomain;

/*!
 @brief This property knows as the path of MobileRTC Resources Bundle, which is readonly for external.
 */
@property (retain, nonatomic, readonly) NSString *mobileRTCResPath;

/*!
 @brief This method returns the MobileRTC default client.
 @discussion This method is guaranteed to only instantiate one sharedSDK over the lifetime of an app.
             This client must be configured with specified client key and client secret.
 @return a preconfigured MobileRTC client
 */
+ (MobileRTC*)sharedRTC;

/*!
 @brief This method sets the MobileRTC client domain.
 @discussion MobileRTC domain should be set while initializing MobileRTC.
 @param domain A domain which used as start/join zoom meeting
 @warning This method is required, please call this method immediately after app launched.
 */
- (void)setMobileRTCDomain:(NSString*)domain;

/*!
 @brief This method sets the path of MobileRTC resource bundle.
 @discussion This method is optional, If not call this method, MobileRTCResources.bundle should be located in main bundle; 
             If call this method, the MobileRTC Resources path should be set while initializing MobileRTC.
 @param path the path of MobileRTC Resources bundle
 */
- (void)setMobileRTCResPath:(NSString *)path;

/*!
 @brief This method gets the MobileRTC client root navigation controller.
 @discussion This method is for internal use, customer usually does not call this method.
 @return a root navigation controller.
 */
- (UINavigationController*)mobileRTCRootController;

/*!
 @brief This method sets the MobileRTC client root navigation controller.
 @discussion This method is optional, If the window's rootViewController of the app is a UINavigationController, you can call this method, or just ignore it.
 @param navController the root navigation controller for pushing MobileRTC meeting UI.
 */
- (void)setMobileRTCRootController:(UINavigationController*)navController;

/*!
 @brief This method returns the MobileRTC version.
 @return the version of MobileRTC
 */
- (NSString*)mobileRTCVersion;

/*!
 @brief This method tells customer whether MobileRTC authorized successfully or not.
 @return A BOOL indicating whether the MobileRTC was authorized or not.
 */
- (BOOL)isRTCAuthorized;

/*!
 @brief This method tells customer whether MobileRTC supports to customize meeting UI or not.
 @return YES, supports to customize meeting UI.
 */
- (BOOL)isSupportedCustomizeMeetingUI;

/*!
 @brief This method returns the MobileRTC default Auth Service.
 @discussion Auth Service should be called at first, the MobileRTC can be used after authorizing successfully.
 @return a preconfigured Auth Service
 */
- (MobileRTCAuthService*)getAuthService;

/*!
 @brief This method returns the MobileRTC default Pre-meeting Service.
 @discussion Pre-meeting Service should be called after signed in with work email, which is used to schedule/eidt/list/delete meeting etc.
 @return a preconfigured Pre-meeting Service
 */
- (MobileRTCPremeetingService*)getPreMeetingService;

/*!
 @brief This method returns the MobileRTC default Meeting Service.
 @return a preconfigured Meeting Service
 */
- (MobileRTCMeetingService*)getMeetingService;

/*!
 @brief This method returns the MobileRTC default Meeting Settings.
 @return a object of Meeting Settings
 */
- (MobileRTCMeetingSettings*)getMeetingSettings;

/*!
 @brief This method returns the MobileRTC default Annotation Service.
 @return a preconfigured Annotation Service
 */
- (MobileRTCAnnotationService*)getAnnotationService;

/*!
 @brief This method returns the MobileRTC default RemoteControl Service.
 @return a preconfigured RemoteControl Service
 */
- (MobileRTCRemoteControlService*)getRemoteControlService;

/*!
 @brief This method gets MobileRTC supported languages.
 @discussion MobileRTC supported languages are English, German, Spanish, Japanese, French, Chinese Simplified, Chinese Traditional.
 @return an array of MobileRTC supported languages
 */
- (NSArray *)supportedLanguages;

/*!
 @brief This method sets the MobileRTC language.
 @discussion the language type should be one of MobileRTC supported languages.
 @param lang one of language type.
 */
- (void)setLanguage:(NSString *)lang;

/*!
 @brief This method is used to set AppGroup name.
 @warning  Method is uesd for iOS Replaykit Screen share integration, function should be called after init SDK
 */
- (void)setAppGroupsName:(NSString*)name;

/*!
 @brief Notify common layer that app will resign active.
 @warning This method is required, please call this method in AppDelegate method "- (void)applicationWillResignActive:(UIApplication *)application".
 */
- (void)appWillResignActive;

/*!
 @brief Notify common layer that app did become active.
 @warning This method is required, please call this method in AppDelegate method "- (void)applicationDidBecomeActive:(UIApplication *)application".
 */
- (void)appDidBecomeActive;

/*!
 @brief Notify common layer that app did enter backgroud.
 @warning This method is required, please call this method in AppDelegate method "- (void)applicationDidEnterBackground:(UIApplication *)application".
 */
- (void)appDidEnterBackgroud;

/*!
 @brief Notify common layer that app will terminate.
 @warning This method is required, please call this method in AppDelegate method "- (void)applicationWillTerminate:(UIApplication *)application".
 */
- (void)appWillTerminate;

@end
