//
//  MobileRTC.h
//  MobileRTC
//
//  Created by Robust Hu on 8/7/14.
//  Copyright (c) 2019 Zoom Video Communications, Inc. All rights reserved.
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
#import <MobileRTC/MobileRTCWaitingRoomService.h>
/*!
 @class MobileRTC
 @brief Initialize the class to acquire all the services. 
 @warning Access to the class and all the other components of the MobileRTC by merging <MobileRTC/MobileRTC.h> into source code.
 @warning The user can only obtain SDK configuration by initializing the class.  
 */
@interface MobileRTC : NSObject
{
    NSString               *_mobileRTCDomain;
    NSString               *_mobileRTCResPath;
    NSString               *_mobileRTCCustomLocalizableName;
    MobileRTCMeetingService         *_meetingService;
    MobileRTCMeetingSettings        *_meetingSettings;
    
    MobileRTCAuthService            *_authService;
    MobileRTCPremeetingService      *_premeetingService;
    
    MobileRTCAnnotationService      *_annotationService;
    
    MobileRTCRemoteControlService   *_remoteControlService;
    MobileRTCWaitingRoomService     *_waitingRoomService;
}

/*!
 @brief MobileRTC domain, read-only.  
 */
@property (retain, nonatomic, readonly) NSString *mobileRTCDomain;

/*!
 @brief The path of MobileRTC Resources Bundle, read-only. 
 */
@property (retain, nonatomic, readonly) NSString *mobileRTCResPath;

/*!
 @brief The name of APP Localizable file for MobileRTC, read-only.
 */
@property (retain, nonatomic, readonly) NSString *mobileRTCCustomLocalizableName;

/*!
 @brief Call the function to initialize MobileRTC.
 @warning The sharedSDK will be instantiated only once over the lifespan of the application. Configure the client with the specified key and secret.
 @param domain The domain is used to start/join a ZOOM meeting.
 @param enableLog Set MobileRTC log enable or not. The path of Log: Sandbox/AppData/tmp/
 */
+ (void)initializeWithDomain:(NSString*)domain enableLog:(BOOL)enableLog;

/*!
 @brief Call the function to initialize MobileRTC.
 @warning The sharedSDK will be instantiated only once over the lifespan of the application. Configure the client with the specified key and secret.
 @warning This method is optional, if the MobileRTCResources.bundle is located in main bundle, please use + (void)initializeWithDomain:(NSString*)domain enableLog:(BOOL)enableLog to initialize MobileRTC; otherwise it is necessary to use the method for initialize MobileRTC.
 @param domain The domain is used to start/join a ZOOM meeting.
 @param enableLog Set MobileRTC log enable or not. The path of Log: Sandbox/AppData/tmp/
 @param bundleResPath Set the path of MobileRTC resource bundle.
 */
+ (void)initializeWithDomain:(NSString*)domain enableLog:(BOOL)enableLog bundleResPath:(NSString*)bundleResPath;

/*!
 @brief Call the function to get the MobileRTC client.
 @warning The sharedSDK will be instantiated only once over the lifespan of the application. Configure the client with the specified key and secret.
 @return A preconfigured MobileRTC client. 
 */
+ (MobileRTC*)sharedRTC;

/*!
 @brief Set MobileRTC client domain.
 @warning Set the domain while initializing MobileRTC. 
 @param domain The domain is used to start/join a ZOOM meeting.
 @warning It is necessary to call the function once the application starts. 
 */
- (void)setMobileRTCDomain:(NSString*)domain;

/*!
 @deprecated This method is deprecated starting in version 4.3
 @note Please use + (void)initializeWithDomain:(NSString*)domain enableLog:(BOOL)enableLog bundleResPath:(NSString*)bundleResPath;
 @brief Set the path of MobileRTC resource bundle.
 @warning This method is optional, the MobileRTCResources.bundle is located in main bundle if the function is not called; otherwise it is necessary to set the MobileRTC Resources path while initializing MobileRTC. 
 @param path The path of MobileRTC Resources bundle.
 */
- (void)setMobileRTCResPath:(NSString *)path DEPRECATED_MSG_ATTRIBUTE("use [+ (void)initializeWithDomain:(NSString*)domain enableLog:(BOOL)enableLog bundleResPath:(NSString*)bundleResPath] instead");

/*!
 @brief Set the name of Localizable file for MobileRTC.
 @warning This method is optional, MobileRTC will read Custom Localizable file from App’s main bundle first.
 @param localizableName The name of APP Localizable file for MobileRTC.
 */
- (void)setMobileRTCCustomLocalizableName:(NSString *)localizableName;

/*!
 @brief Get the root navigation controller of MobileRTC client.  
 @warning This method is for internal use, the user generally won't call the method. 
 @return The root navigation controller.
 */
- (UINavigationController*)mobileRTCRootController;

/*!
 @brief Set the MobileRTC client root navigation controller.   
 @warning This method is optional, call the method if the window's rootViewController of the application is the UINavigationController, or just ignore it.
 @param navController The root navigation controller for pushing MobileRTC meeting UI. 
 */
- (void)setMobileRTCRootController:(UINavigationController*)navController;

/*!
 @brief Check the MobileRTC version.  
 @return The version of MobileRTC.
 */
- (NSString*)mobileRTCVersion;

/*!
 @brief Query if the MobileRTC is authorized successfully or not. 
 @return YES indicates authorized successfully. Otherwise not.
 */
- (BOOL)isRTCAuthorized;

/*!
 @brief Query if custom meeting UI is supported by MobileRTC. 
 @return YES indicates support. Otherwise not.
 */
- (BOOL)isSupportedCustomizeMeetingUI;

/*!
 @brief Get the default authentication service.  
 @warning The MobileRTC can not be called unless the authentication service is called successfully. 
 @return The preconfigured authentication service. 
 */
- (MobileRTCAuthService*)getAuthService;

/*!
 @brief Get the default pre-meeting service. 
 @warning Pre-meeting Service will be called once the user logged in with a work email, it is used to schedule/edit/list/delete a meeting.
 @return The preconfigured pre-meeting service.
 */
- (MobileRTCPremeetingService*)getPreMeetingService;

/*!
 @brief Get the default meeting service.  
 @return The default meeting service.  
 */
- (MobileRTCMeetingService*)getMeetingService;

/*!
 @brief Get the MobileRTC default meeting settings. 
 @return The MobileRTC default meeting settings. 
 */
- (MobileRTCMeetingSettings*)getMeetingSettings;

/*!
 @brief Get the MobileRTC default annotation service.   
 @return The preconfigured annotation service.  
 */
- (MobileRTCAnnotationService*)getAnnotationService;

/*!
 @brief Get the default MobileRTC remote control service.   
 @return The preconfigured remote control service. 
 */
- (MobileRTCRemoteControlService*)getRemoteControlService;

/*!
 @brief Get the default MobileRTC waiting room service.
 @return The MobileRTC waiting room service.
 */
- (MobileRTCWaitingRoomService *)getWaitingRoomService;

/*!
 @brief Get the languages supported by MobileRTC.   
 @warning The languages supported by MobileRTC are English, German, Spanish, Japanese, French, Simplified Chinese, Traditional Chinese.
 @return An array of languages supported by MobileRTC.
 */
- (NSArray *)supportedLanguages;

/*!
 @brief Set the MobileRTC language.
 @warning Choose one of the languages supported by MobileRTC.  
 @param lang The specified language.  
 */
- (void)setLanguage:(NSString *)lang;

/*!
 @brief Set the AppGroup ID of the application. 
 @warning The Method is used for iOS Replaykit Screen share integration and should be called after SDK initiation.
 */
- (void)setAppGroupsName:(NSString*)appGroupId;

/*!
 @brief Notify common layer that application will resign active. Call the systematical method and then call the appWillResignActive via applicationWillResignActive.
 @warning It is necessary to call the method in AppDelegate "- (void)applicationWillResignActive:(UIApplication *)application".  
 */
- (void)appWillResignActive;

/*!
 @brief Notify common layer that application did become active. Call the appDidBecomeActive via applicationDidBecomeActive.
 @warning It is necessary to call the method in AppDelegate "- (void)applicationDidBecomeActive:(UIApplication *)application". 
 */
- (void)appDidBecomeActive;

/*!
 @brief Notify common layer that application did enter background. Call the appDidEnterBackgroud via applicationDidEnterBackground.
 @warning It is necessary to call the method in AppDelegate "- (void)applicationDidEnterBackground:(UIApplication *)application".
 */
- (void)appDidEnterBackgroud;

/*!
 @brief Notify common layer that application will terminate. Call the appWillTerminate via applicationWillTerminate.
 @warning It is necessary to call the method in AppDelegate "- (void)applicationWillTerminate:(UIApplication *)application".
 */
- (void)appWillTerminate;

@end
