//
//  MobileRTC.h
//  MobileRTC
//
//  Created by Zoom Video Communications on 8/7/14.
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
#import <MobileRTC/MobileRTCMeetingService+VirtualBackground.h>
#import <MobileRTC/MobileRTCMeetingService+BO.h>
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
#import <MobileRTC/MobileRTCRenderer.h>
#import <MobileRTC/MobileRTCAudioRawDataHelper.h>
#import <MobileRTC/MobileRTCSMSService.h>

/*!
 @brief MobileRTCSDKInitContext.
 */
@interface MobileRTCSDKInitContext : NSObject
/*!
 @brief [Required] domain The domain is used to start/join a ZOOM meeting.
 */
@property (nonatomic, copy)   NSString                      * _Nullable domain;
/*!
 @brief [Optional] enableLog Set MobileRTC log enable or not. The path of Log: Sandbox/AppData/tmp/
 */
@property (nonatomic, assign) BOOL                          enableLog;
/*!
 @brief [Optional] bundleResPath Set the path of MobileRTC resource bundle.
 */
@property (nonatomic, copy) NSString                        * _Nullable bundleResPath;
/*!
 @brief [Optional] Locale fo Customer.
 */
@property (nonatomic, assign) MobileRTC_ZoomLocale          locale;
/*!
 @brief [Optional] The video rawdata memory mode. Default is MobileRTCRawDataMemoryModeStack, only for rawdataUI.
 */
@property (nonatomic, assign) MobileRTCRawDataMemoryMode    videoRawdataMemoryMode;
/*!
 @brief [Optional] The share rawdata memory mode. Default is MobileRTCRawDataMemoryModeStack, only for rawdataUI.
 */
@property (nonatomic, assign) MobileRTCRawDataMemoryMode    shareRawdataMemoryMode;
/*!
 @brief [Optional] The audio rawdata memory mode. Default is MobileRTCRawDataMemoryModeStack, only for rawdataUI.
 */
@property (nonatomic, assign) MobileRTCRawDataMemoryMode    audioRawdataMemoryMode;
/*!
 @brief [Optional] If you use screen share, you need create group id in your apple developer account, and setup here.
 */
@property (nonatomic, copy) NSString                        * _Nullable appGroupId;
@end

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
    
    MobileRTCSMSService             *_smsService;
}

/*!
 @brief MobileRTC domain, read-only.  
 */
@property (retain, nonatomic, readonly) NSString * _Nullable mobileRTCDomain;

/*!
 @brief The path of MobileRTC Resources Bundle, read-only. 
 */
@property (retain, nonatomic, readonly) NSString * _Nullable mobileRTCResPath;

/*!
 @brief The name of APP Localizable file for MobileRTC, read-only.
 */
@property (retain, nonatomic, readonly) NSString * _Nullable mobileRTCCustomLocalizableName;

/*!
 @brief Call the function to get the MobileRTC client.
 @warning The sharedSDK will be instantiated only once over the lifespan of the application. Configure the client with the specified key and secret.
 @return A preconfigured MobileRTC client.
 */
+ (MobileRTC * _Nonnull)sharedRTC;

/*!
 @brief Call the function to initialize MobileRTC.
 @warning The instance will be instantiated only once over the lifespan of the application.
 @param context Initialize the parameter configuration of the SDK, please See [MobileRTCSDKInitContext]
 */
- (BOOL)initialize:(MobileRTCSDKInitContext * _Nonnull)context;

/*!
 @brief Call the function to switch MobileRTC domain.
 @param newDomain The new domain.
 @return YES indicates successfully. Otherwise not.
 */
- (BOOL)switchDomain:(NSString * _Nonnull)newDomain force:(BOOL)force;

/*!
 @brief Set the name of Localizable file for MobileRTC.
 @warning This method is optional, MobileRTC will read Custom Localizable file from App’s main bundle first.
 @param localizableName The name of APP Localizable file for MobileRTC.
 */
- (void)setMobileRTCCustomLocalizableName:(NSString * _Nullable)localizableName;

/*!
 @brief Get the root navigation controller of MobileRTC client.  
 @warning This method is for internal use, the user generally won't call the method. 
 @return The root navigation controller.
 */
- (UINavigationController * _Nullable)mobileRTCRootController;

/*!
 @brief Set the MobileRTC client root navigation controller.   
 @warning This method is optional, call the method if the window's rootViewController of the application is the UINavigationController, or just ignore it.
 @param navController The root navigation controller for pushing MobileRTC meeting UI. 
 */
- (void)setMobileRTCRootController:(UINavigationController * _Nullable)navController;

/*!
 @brief Check the MobileRTC version.  
 @return The version of MobileRTC.
 */
- (NSString * _Nullable)mobileRTCVersion;

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
- (MobileRTCAuthService * _Nullable)getAuthService;

/*!
 @brief Get the default pre-meeting service. 
 @warning Pre-meeting Service will be called once the user logged in with a work email, it is used to schedule/edit/list/delete a meeting.
 @return The preconfigured pre-meeting service.
 */
- (MobileRTCPremeetingService * _Nullable)getPreMeetingService;

/*!
 @brief Get the default meeting service.  
 @return The default meeting service.  
 */
- (MobileRTCMeetingService * _Nullable)getMeetingService;

/*!
 @brief Get the MobileRTC default meeting settings. 
 @return The MobileRTC default meeting settings. 
 */
- (MobileRTCMeetingSettings * _Nullable)getMeetingSettings;

/*!
 @brief Get the MobileRTC default annotation service.   
 @return The preconfigured annotation service.  
 */
- (MobileRTCAnnotationService * _Nullable)getAnnotationService;

/*!
 @brief Get the default MobileRTC remote control service.   
 @return The preconfigured remote control service. 
 */
- (MobileRTCRemoteControlService * _Nullable)getRemoteControlService;

/*!
 @brief Get the default MobileRTC waiting room service.
 @return The MobileRTC waiting room service.
 */
- (MobileRTCWaitingRoomService * _Nullable)getWaitingRoomService;

/*!
 @brief Get the default MobileRTC sms service.
 @return The MobileRTC sms service.
 */
- (MobileRTCSMSService * _Nullable)getSMSService;

/*!
 @brief Get the languages supported by MobileRTC.   
 @warning The languages supported by MobileRTC are English, German, Spanish, Japanese, French, Simplified Chinese, Traditional Chinese.
 @return An array of languages supported by MobileRTC.
 */
- (NSArray * _Nonnull)supportedLanguages;

/*!
 @brief Set the MobileRTC language.
 @warning Choose one of the languages supported by MobileRTC.  
 @param lang The specified language.  
 */
- (void)setLanguage:(NSString * _Nullable)lang;

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

/*!
 @brief Gets whether you have permission to use raw data.
 @warning It is necessary to call the method after auth success.
 */
- (BOOL)hasRawDataLicense;

@end
