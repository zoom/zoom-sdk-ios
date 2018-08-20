//
//  MobileRTCMeetingUserInfo.h
//  MobileRTC
//
//  Created by Robust Hu on 2017/2/27.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MobileRTCVideoStatus : NSObject

@property (nonatomic, assign) BOOL  isSending;
@property (nonatomic, assign) BOOL  isReceiving;
@property (nonatomic, assign) BOOL  isSource;

@end

/*!
 @brief MobileRTCDeviceEncryptType An Enum for Audio Type.
 */
typedef enum {
    ///VoIP
    MobileRTCAudioType_VoIP   = 0,
    ///Telephony
    MobileRTCAudioType_Telephony,
    ///None
    MobileRTCAudioType_None,
}MobileRTCAudioType;

@interface MobileRTCAudioStatus : NSObject

@property (nonatomic, assign) BOOL  isMuted;
@property (nonatomic, assign) BOOL  isTalking;
@property (nonatomic, assign) MobileRTCAudioType  audioType;

@end

typedef enum {
    MobileRTCFeedbackType_None    = 0,
    MobileRTCFeedbackType_Hand,
    MobileRTCFeedbackType_Yes,
    MobileRTCFeedbackType_No,
    MobileRTCFeedbackType_Fast,
    MobileRTCFeedbackType_Slow,
    MobileRTCFeedbackType_Good,
    MobileRTCFeedbackType_Bad,
    MobileRTCFeedbackType_Clap,
    MobileRTCFeedbackType_Coffee,
    MobileRTCFeedbackType_Clock,
    MobileRTCFeedbackType_Emoji,
}MobileRTCFeedbackType;

@interface MobileRTCMeetingUserInfo : NSObject

@property (nonatomic, assign) NSUInteger       userID;
@property (nonatomic, retain) NSString*        userName;
@property (nonatomic, retain) NSString*        emailAddress;
@property (nonatomic, retain) NSString*        avatarPath;
@property (nonatomic, assign) NSInteger        unread;
@property (nonatomic, retain) MobileRTCVideoStatus*  videoStatus;
@property (nonatomic, retain) MobileRTCAudioStatus*  audioStatus;
@property (nonatomic, assign) BOOL             handRaised;
@property (nonatomic, assign) BOOL             inSilentMode;
@property (nonatomic, assign) BOOL             isCohost;
@property (nonatomic, assign) BOOL             isHost;
@property (nonatomic, assign) BOOL             isSharingPureComputerAudio;
@property (nonatomic, assign) MobileRTCFeedbackType  feedbackType;

@end


@interface MobileRTCMeetingWebinarAttendeeInfo : NSObject

@property (nonatomic, assign, readonly) NSUInteger userID;
@property (nonatomic, retain, readonly) NSString *userName;
@property (nonatomic, retain, readonly) NSString *emailAddress;

- (id)initWithUserID:(NSUInteger)userID username:(NSString *)userName emailAddress:(NSString*)emailAddress;

@end
