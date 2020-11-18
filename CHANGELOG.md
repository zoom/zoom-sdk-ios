# CHANGELOG

## 2020-11-17 @ v5.2.42037.1112

## Added:
* Added new feature for supporting language interpreters within meetings. For info about this feature, please visit: https://support.zoom.us/hc/en-us/articles/360034919791-Language-interpretation-in-meetings-and-webinars  The new interfaces can be found in `MobileRTCMeetingService+Interpretation.h`:
```  
@interface MobileRTCInterpretationLanguage : NSObject
  - (NSInteger)getLanguageID;
  - (NSString * _Nullable)getLanguageAbbreviations;
  - (NSString * _Nullable)getLanguageName;
  @end

  @interface MobileRTCMeetingInterpreter : NSObject
  - (NSInteger)getUserID;
  - (NSInteger)getLanguageID1;
  - (NSInteger)getLanguageID2;
  - (BOOL)isAvailable;
  @end
```

  * Added the following members to `MobileRTCMeetingService`:
      * `- (BOOL)isInterpretationEnabled;`
      * `- (BOOL)isInterpretationStarted;`
      * `- (BOOL)isInterpreter;`
      * `- (MobileRTCInterpretationLanguage * _Nullable)getInterpretationLanguageByID:(NSInteger)lanID;`
      * `- (NSArray <MobileRTCInterpretationLanguage *> * _Nullable)getAllLanguageList;`
      * `- (NSArray <MobileRTCMeetingInterpreter *> * _Nullable)getInterpreterList;`
      * `- (BOOL)addInterpreter:(NSUInteger)userID lan1:(NSInteger)lanID1 andLan2:(NSInteger)lanID2;`
      * `- (BOOL)removeInterpreter:(NSUInteger)userID; `
      * `- (BOOL)modifyInterpreter:(NSUInteger)userID lan1:(NSInteger)lanID1 andLan2:(NSInteger)lanID2;`
      * `- (BOOL)startInterpretation;`
      * `- (BOOL)stopInterpretation;`
      * `- (NSArray <MobileRTCInterpretationLanguage *> * _Nullable)getAvailableLanguageList;`
      * `- (BOOL)joinLanguageChannel:(NSInteger)lanID;`
      * `- (NSInteger)getJoinedLanguageID;`
      * `- (BOOL)turnOffMajorAudio;`
      * `- (BOOL)turnOnMajorAudio;`
      * `- (BOOL)isMajorAudioTurnOff;`
      * `- (NSArray <MobileRTCInterpretationLanguage *> * _Nullable)getInterpreterLans;`
      * `- (BOOL)setInterpreterActiveLan:(NSInteger)activeLanID;`
      * `- (NSInteger)getInterpreterActiveLan;`

  * Added new delegate for language interpretation callbacks:
      ```
      @protocol MobileRTCInterpretationServiceDelegate <MobileRTCMeetingServiceDelegate>
      - (void)onInterpretationStart;
      - (void)onInterpretationStop;
      - (void)onInterpreterListChanged;
      - (void)onInterpreterRoleChanged:(NSUInteger)userID isInterpreter:(BOOL)isInterpreter;
      - (void)onInterpreterActiveLanguageChanged:(NSInteger)userID activeLanguageId:(NSInteger)activeLanID;
      - (void)onInterpreterLanguageChanged:(NSInteger)lanID1 andLanguage2:(NSInteger)lanID2;
      - (void)onAvailableLanguageListUpdated:(NSArray <MobileRTCInterpretationLanguage *> *_Nullable)availableLanguageList;
      ```

* Added new interface to support Direct Share. For info about this feature, please visit: https://support.zoom.us/hc/en-us/articles/214629303-Direct-sharing-in-Zoom-Rooms
  The new interface can be found in `MobileRTCDirectShareService.h`:
  * `- (BOOL)TryWithMeetingNumber:(NSString *_Nonnull)meetingNumber;`
  * `- (BOOL)TryWithPairingCode:(NSString *_Nonnull)pairingCode;`
  * `- (BOOL)cancel;`
  * `- (void)onDirectShareStatusUpdate:(MobileRTCDirectShareStatus)status handler:(MobileRTCDirectShareViaMeetingIDOrPairingCodeHandler  *_Nullable)handler;`
  * `- (BOOL)canStartDirectShare;`
  * `- (BOOL)isDirectShareInProgress;`
  * `- (BOOL)startDirectShare;`
  * `- (BOOL)stopDirectShare;`

* Added new members to disable copying Zoom URL when long pressing meeting ID
  The new members were added in `MobileRTCMeetingSettings.h`:
  * `- (BOOL)copyMeetingUrlDisabled;`
  * `- (void)disableCopyMeetingUrl:(BOOL)disabled;`

* Added new callback to notify the end-user that their video subscription failed when using Custom Meeting UI
  The interface in MobileRTCMeetingDelegate.h:
  * `- (void)onSubscribeUserFail:(NSInteger)errorCode size:(NSInteger)size userId:(NSUInteger)userId;`
* Updated current enums to be NSEnums.

## Changed & Fixed:
* Fixed an issue that the `raiseMyHand` or `lowerHand` is not working properly when in a webinar.
* Fixed an issue that the userID provided in the callback is incorrect when leaving the waiting room.
* Fixed an issue that not setting the appGroupId while initializing the SDK results in crash
* Fixed an issue that the SDK crashes when running on the devices that are iOS 9 or lower.

## 2020-10-22 @ v5.2.41739.1022

## Changed & Fixed:

* Fixed an issue that not setting the appGroupId while initializing the SDK results in crash
* Fixed an issue that the SDK crashes when running on the devices that are iOS 9 or lower.

## 2020-10-09 @ v5.2.41735.0928

## Added:
* Upgraded Zoom default UI to match Zoom client 5.2.1, including but not limit to the following new features:
  * Dark mode support
  * Support for split screen multitasking on iPad (Does not support 2 Zoom SDK apps running at the same time)
  * Improved video and content sharing
* iOS 14 support (Conditional)
   * SDK does not support the new features that are newly introduced in iOS 14, such as App Clip; If you are using prior features, SDK could be built and run on iOS 14 
* Added new callbacks for audio/video status:
  * The interface in `MobileRTCMeetingDelegate.h`:
      * `- (void)onSinkMeetingAudioStatusChange:(NSUInteger)userID audioStatus:(MobileRTC_AudioStatus)audioStatus;`
      * `- (void)onSinkMeetingVideoStatusChange:(NSUInteger)userID videoStatus:(MobileRTC_VideoStatus)videoStatus;`
* Added a new interface to get participantID in `MobileRTCMeetingUserInfo`.
  * The interface in `MobileRTCMeetingUserInfo.h`:
      * `@property (nonatomic, retain) NSString* _Nullable  participantID;`
* Added new callbacks for free meeting upgrade prompt
  * The interface in `MobileRTCMeetingDelegate.h`:
      * `- (void)onFreeMeetingNeedToUpgrade:(FreeMeetingNeedUpgradeType)type giftUpgradeURL:(NSString*_Nullable)giftURL;`
      * `- (void)onFreeMeetingUpgradeToGiftFreeTrialStart;`
      * `- (void)onFreeMeetingUpgradeToGiftFreeTrialStop;`
      * `- (void)onFreeMeetingUpgradedToProMeeting;`
* Added new callbacks for the event when the webinar attendee is allowed or disallowed to talk.
  * The interface in `MobileRTCMeetingDelegate.h`:
      * `- (void)onSinkSelfAllowTalkNotification;`
      * `- (void)onSinkSelfDisallowTalkNotification;`
* Added new interfaces for the feature "Allow participants to rename themselves".
  * The interface in `MobileRTCMeetingService+InMeeting.h`:
      * `- (BOOL)isParticipantsRenameAllowed;`
      * `- (void)allowParticipantsToRename:(BOOL)allow;`
* Added new interfaces for the feature "Allow participants to unmute Themselves".
  * The interface in `MobileRTCMeetingService+InMeeting.h`:
      * `- (BOOL)isParticipantsUnmuteSelfAllowed;`
      * `- (void)allowParticipantsToUnmuteSelf:(BOOL)allow;`
* Added a new interface to allow the host/co-host to ask to unmute all participant's audio.
  * The interface in `MobileRTCMeetingService+Audio.h`:
      * `- (BOOL)askAllToUnmute;`
* Added new interfaces to delete questions and answers in the webinar Q&A.
  * The interface in `MobileRTCMeetingService+Webinar.h` and `MobileRTCMeetingDelegate.h`:
      * `- (BOOL)deleteQuestion:(nonnull NSString *)questionID;`
      * `- (BOOL)deleteAnswer:(nonnull NSString *)answerID;`
      * `- (void)onSinkDeleteQuestion:(NSArray *_Nonnull)questionIDArray;`
      * `- (void)onSinkDeleteAnswer:(NSArray *_Nonnull)answerIDArray;`
* Added a new interface to disable virtual background.
  * The interface in `MobileRTCMeetingSettings.h`:
      * `- (BOOL)virtualBackgroundDisabled;`
      * `- (void)disableVirtualBackground:(BOOL)disabled;`
* Added chatMessageType in the MobileRTCMeetingChat object to show the chat message type.
  * The interface in `MobileRTCMeetingChat.h`:
      * `@property (nonatomic, readwrite) MobileRTCChatMessageType chatMessageType;`
* Added a new interface isH323User in MobileRTCMeetingUserInfo to check whether the user is an H.323 user.
  * The interface in `MobileRTCMeetingUserInfo.h`:
      * `@property (nonatomic, assign) BOOL             isH323User;`
* Added a new interface to check whether it is allowed to claim host.
  * The interface in `MobileRTCMeetingUserInfo.h`:
      * `- (BOOL)canClaimhost;`
* Added new interfaces for participants to request for help and to broadcast messages while in the Breakout Room(BO).
  * The interface in `MobileRTCBORole.h`
      * `- (BOOL)ignoreUserHelpRequest:(NSString *)boUserId;`
      * `- (BOOL)broadcastMessage:(NSString * _Nullable)strMsg;`
      * `- (BOOL)requestForHelp;`
      * `- (BOOL)isHostInThisBO;`
      * `- (NSString  * _Nullable)getCurrentBOName;`
      * `- (BOOL)isBOUserMyself:(NSString *_Nullable)boUserId;`
* Added new callbacks for the events when the privilege has changed in the breakout room.
  * The interface in `MobileRTCMeetingDelegate.h`:
      * `- (void)onLostAssistantRightsNotification:(BOOL)isStopBO;`
      * `- (void)onLostAttendeeRightsNotification:(BOOL)isStopBO;`
* Added new callbacks for the events when the attendees seek for help or broadcast a message in the breakout room.
  * The interface in `MobileRTCMeetingDelegate.h`:
      * `- (void)onNewBroadcastMessageReceived:(NSString *_Nullable)broadcastMsg;`
      * `- (void)onHelpRequestReceived:(NSString *_Nullable)strUserID;`
      * `- (void)onHelpRequestHandleResultReceived:(MobileRTCBOHelpReply)eResult;`
      * `- (void)onHostJoinedThisBOMeeting;`
      * `- (void)onHostLeaveThisBOMeeting;`
* Added Vietnamese and Italian language support.

## Changed & Fixed:

* MobileRTCScreenShareService now requires that the following frameworks need to be added to the Broadcast Extension target in addition to ReplayKit:

    * `CoreGraphics.framework`
    * `CoreVideo.framework`
    * `CoreMedia.framework`
    * `VideoToolbox.framework`
* MobileRTCScreenShareService also now requires that SampleHandler.m be SampleHandler.mm. If using swift instead, the linker flag -lc++ must be added to the Broadcast Extension’s build settings under “Other linker flags”
* Refined the In Meeting States:
   ```
      typedef enum {
          MobileRTCMeetingState_Idle,///<No meeting is running.
          MobileRTCMeetingState_Connecting,///<Connect to the meeting server status.
          MobileRTCMeetingState_WaitingForHost,///<Waiting for the host to start the meeting.
          MobileRTCMeetingState_InMeeting,///<Meeting is ready, in meeting status.
          MobileRTCMeetingState_Disconnecting,///<Disconnect the meeting server, leave meeting status.
          MobileRTCMeetingState_Reconnecting,///<Reconnecting meeting server status.
          MobileRTCMeetingState_Failed,///<Failed to connect the meeting server.
          MobileRTCMeetingState_Ended,///<Meeting ends.
          MobileRTCMeetingState_Unknow,///<Unknown status.
          MobileRTCMeetingState_Locked,///<Meeting is locked to prevent the further participants from joining the meeting.       MobileRTCMeetingState_Unlocked,///<Meeting is open and participants can join the meeting.
          MobileRTCMeetingState_InWaitingRoom,///<Participants who join the meeting before the start are in the waiting room.
          MobileRTCMeetingState_WebinarPromote,///<Upgrade the attendees to panelist in webinar.
          MobileRTCMeetingState_WebinarDePromote,///<Downgrade the attendees from the panelist.
          MobileRTCMeetingState_JoinBO,///<Join the breakout room.
          MobileRTCMeetingState_LeaveBO,///<Leave the breakout room.
          MobileRTCMeetingState_WaitingExternalSessionKey,///<Waiting for the additional secret key.
      }MobileRTCMeetingState;
    ```
* Changed the minimum supported version of the MobileRTCScreenShare.Framework to iOS8.
* Fixed an issue that error appears when trying to get the user ID of the active shared user and no one is sharing.
* Fixed an issue that sets the width of the highlighters in annotation does not work.
* Fixed an issue that checking the shared privilege returns incorrect results when using Custom UI.
* Fixed an issue that the video preview does not present when the mobileRTCRootController is not being configured.
* Fixed an issue where the  SDK becomes unresponsive when joining the meeting with meeting ID "000000".
* Fixed an issue that the "The host has ended the meeting " alert can not be hidden.
* Fixed an issue that using the virtual background interface results in getting "unable to find the symbol and cannot rename" error
* Fixed an issue that prevented users from customizing the meeting title in the waiting room view.
* Fixed an issue that the tip string text in the call-in UI in German overlaps itself.
* Fixed an issue that the callback is not being triggered when raising/lowering the hand in the webinar.
* Fixed an issue that the disclaimer window does not display when the MobileRTCRootViewController is not properly configured.
* Fixed an issue that the watermark overlaps with the battery/connectivity status icons.
* Fixed an issue that the screen sharing feature causes crashes on iPadOS 14.


## Deprecated & Removed:

* `- (void)onFreeMeetingReminder:(BOOL)host canFreeUpgrade:(BOOL)freeUpgrade isFirstGift:(BOOL)first completion:(void (^_Nonnull)(BOOL upgrade))completion DEPRECATED_ATTRIBUTE;`
* `- (BOOL)isAllowAttendeeAnswerQuestion DEPRECATED_MSG_ATTRIBUTE("Had deprecated. Please use - (BOOL)isAllowCommentQuestion; instead");`
* `- (BOOL)allowAttendeeAnswerQuestion:(BOOL)enable     DEPRECATED_MSG_ATTRIBUTE("Had deprecated. Please use - (BOOL)allowCommentQuestion:(BOOL)enable; instead");`

## 2020-06-30 @ v5.0.24433.0616

## Added:

* Upgraded Zoom default UI to match Zoom client 5.0.
* Added a new interface to modify the 'meeting topic' in the 'meeting information' page.
  * The interface in `MobileRTCPremeetingService.h`:
    * `- (BOOL)setMeetingTopic:(NSString *_Nonnull)meetingTopic;`
* Added a new callback for the event when the username has changed
  * The interface in `MobileRTCMeetingDelegate.h`:
    * `- (void)onSinkUserNameChanged:(NSUInteger)userID userName:(NSString *_Nonnull)userName;`
* Added new interfaces related to setting 'Always show video preview when joining a video meeting' feature.
  * The interface in `MobileRTCMeetingSettings.h:`
    * `- (BOOL)showVideoPreviewWhenJoinMeetingDisabled;`
    * `- (void)disableShowVideoPreviewWhenJoinMeeting:(BOOL)disabled;`
* Added a new interface to start meeting.
   * The interface in `MobileRTCMeetingService.h`:
    * `- (MobileRTCMeetError)startMeetingWithStartParam:(nonnull MobileRTCMeetingStartParam*)param;`
* Added new interfaces for the "Use Original Sound" option in the meeting settings.
   * The interface in `MobileRTCMeetingSettings.h`:
    * `- (BOOL)micOriginalInputEnabled;`
    * `- (void)enableMicOriginalInput:(BOOL)enable;`
* Added new interfaces to check whether the PMI option is enabled on the account.
   * The interface in `MobileRTCPremeetingService.h`:
    * `- (BOOL)isDisabledPMI;`
    * `- (BOOL)setUsePMIAsMeetingID:(BOOL)usePMI;`
* Redefined the start/join meeting interface.
   * The interface in `MobileRTCMeetingService.h`:
    * `- (MobileRTCMeetError)startMeetingWithStartParam:(nonnull MobileRTCMeetingStartParam*)param;`
    * `- (MobileRTCMeetError)joinMeetingWithJoinParam:(nonnull MobileRTCMeetingJoinParam*)param;`
* Added new interfaces to hide the "Promote to Panelist" and "Change to Attendee” options.
    * The interface in `MobileRTCMeetingSettings.h`
     * `@property (assign, nonatomic) BOOL promoteToPanelistHidden;`
     * `@property (assign, nonatomic) BOOL changeToAttendeeHidden;`
* Optimized the status of H.323 call out.

## Changed & Fixed:

* Fixed an issue that the strings in the camera permission request prompt are failed to be translated.
* Fixed an issue that the audio status is not shown correctly when joining a meeting that is sharing.
* Fixed an issue that the app on the attendee side of a webinar crashes when the host changes the view to gallery view.
* Fixed an issue that uploading the MobileRTCScreenShare.frameworks to App Store or TestFlight will result in errors.
* Fixed an issue that the user ID returns in the audio status callback and the waiting room callback is incorrect.
* Fixed an issue that the app crashes when using annotation in Custom UI mode.
* Fixed an issue that the webinar host cannot change the attendee's display name.
* Fixed an issue that the attendee cannot receive messages sent by the host while in the waiting room.
* Temporary remove the "Unmute all" interfaces.

## Deprecated:

* `- (MobileRTCMeetError)startMeetingWithDictionary:(nonnull NSDictionary*)dict;`
* `- (MobileRTCMeetError)joinMeetingWithDictionary:(nonnull NSDictionary*)dict;`

## Removed:

* `+ (void)initializeWithDomain:(NSString * _Nonnull)domain enableLog:(BOOL)enableLog;`
* `+ (void)initializeWithDomain:(NSString * _Nonnull)domain enableLog:(BOOL)enableLog bundleResPath:(NSString * _Nullable)bundleResPath;`
* `- (void)setMobileRTCDomain:(NSString * _Nonnull)domain;`
* `- (void)setMobileRTCResPath:(NSString * _Nullable)path;`
* `- (void)setAppGroupsName:(NSString * _Nullable)appGroupId;`
* `- (BOOL)unmuteAllUserAudio;`

## 2020-04-28 @ v4.6.21666.0428

## Added:
* Added support for AES 256-bit GCM encryption.
  * **Please plan to upgrade your SDK accordingly. See the announcement in [README](https://github.com/zoom/zoom-sdk-ios)  for more information**
* Added a new interface to hide Reaction emoji
  * `-(void)hideReactionsOnMeetingUIBOOL)hidden;` in `MobileRTCMeetingSettings.h`

## Changed & Fixed:
* Upgraded OpenSSL to version 1.1.1e
* Fixed an issue that the screen sharing is not working properly when using Custom UI
* Fixed an issue that the chat button is still visible in the "More" menu when the chat is disabled

## Deprecated
* Deprecated the interface to get user's email: `MobileRTCMeetingUserInfo.emailAddress`

## 2020-04-04 @ v4.6.15805.0403

## Added:
 * Add new interfaces for customizing [breakout room](https://support.zoom.us/hc/en-us/articles/206476093-Getting-Started-with-Breakout-Rooms)
  * `MobileRTCMeetingService.h`:
    * `- (MobileRTCBOCreator * _Nullable)getCreatorHelper;`
    * `- (MobileRTCBOAdmin * _Nullable)getAdminHelper;`
    * `- (MobileRTCBOAssistant * _Nullable)getAssistantHelper;`
    * `- (MobileRTCBOAttendee * _Nullable)getAttedeeHelper;`
    * `- (MobileRTCBOData * _Nullable)getDataHelper;`
    * `- (BOOL)isMasterMeetingHost;`
    * `- (BOOL)isBOMeetingStarted;`
    * `- (BOOL)isBOMeetingEnabled;`
    * `- (BOOL)isInBOMeeting;`
  * ` MobileRTCMeetingDelegate.h`:
    * `- (void)onBOInfoUpdated:(NSString *_Nullable)boId;`
    * `- (void)onUnAssignedUserUpdated;`
  * `MobileRTCBORole.h`:
    * `MobileRTCBOUser`:
      * `- (NSString * _Nullable)getUserId;`
      * `- (NSString * _Nullable)getUserName;`
      * `- (MobileRTCBOUserStatus)getUserStatus;`
    * `MobileRTCBOMeeting`:
      * `- (NSString * _Nullable)getBOMeetingId;`
      * `- (NSString * _Nullable)getBOMeetingName;`
      * `- (NSArray * _Nullable)getBOMeetingUserList;`
    * `MobileRTCBOCreator`:
      * `- (NSString * _Nullable)createBO:(NSString * _Nullable)boName;`
      * `- (BOOL)updateBO:(NSString * _Nullable)boId name:(NSString *_Nullable)boName;`
      * `- (BOOL)removeBO:(NSString * _Nullable)boId;`
      * `- (BOOL)assignUser:(NSString * _Nullable)boUserId toBO:(NSString * _Nullable)boId;`
      * `- (BOOL)removeUser:(NSString * _Nullable)boUserId fromBO:(NSString * _Nullable)boId;`
    * `MobileRTCBOAdmin`:
      * `- (BOOL)startBO;`
      * `- (BOOL)stopBO;`
      * `- (BOOL)assignNewUser:(NSString * _Nullable)boUserId toRunningBO:(NSString * _Nullable)boId;`
      * `- (BOOL)switchUser:(NSString * _Nullable)boUserId toRunningBO:(NSString * _Nullable)boId;`
      * `- (BOOL)canStartBO;`
    * `MobileRTCBOAssistant`:
      * `- (BOOL)joinBO:(NSString * _Nullable)boId;`
      * `- (BOOL)leaveBO;`
    * `MobileRTCBOAttendee`:
      * `- (BOOL)joinBO;`
      * `- (BOOL)leaveBO;`
      * `- (NSString * _Nullable)getBOName;`
    * `MobileRTCBOData`:
      * `- (NSArray * _Nullable)getUnassignedUserList;`
      * `- (NSArray * _Nullable)getBOMeetingIDList;`
      * `- (MobileRTCBOUser * _Nullable)getBOUserByUserID:(NSString * _Nullable)userId;`
      * `- (MobileRTCBOMeeting * _Nullable)getBOMeetingByID:(NSString * _Nullable)boId;`

* Add new interfaces and options for schedule meeting
   * New interfaces can be found in `MobileRTCPremeetingService.h`

* Add an interface to allow webinar participants to pre-enter the registration information, and skip the pop-up
   * `- (void)prePopulateWebinarRegistrationInfo:(nonnull NSString *)email username:(nonnull NSString *)username;`

* Add new callbacks to get notified on the chat privilege change events
   * `- (void)onSinkAllowAttendeeChatNotification:(MobileRTCChatAllowAttendeeChat)currentPrivilege;`


## Changed & Fixed:
* Fixed an issue that the SDK was not able to connect to audio if the app has configured the Category in `AVAudioSession`
* Fixed an issue that the app occasionally crashes when someone is sharing the screen on iPad and then an attendee joins the meeting
* Fixed an issue that unable to end a meeting on iPad
* Fixed an issue that the interface `showMinimizeMeeting` was not working on iPad
* Fixed an issue that the app crashes when an attendee has been promoted to a panelist in a webinar and then start streaming

## 2020-02-10 @ v4.6.15084.0206

## Added:
* Add new features in Zoom default UI
  * Allow Call-In Attendees to unmute in the webinar
  * Closed captioning in breakout sessions
  * Support for multiple pages on the whiteboard
  * Audio setting for auto-select based on network
  * Switch between video and content sharing
  * Zoom in/out on their camera
  * Annotation enhancements
  * Reduced volume for entering/exiting chime
  * Rename meeting hosted with personal meeting ID
  * Push notification for contact requests
  * Rename webinar attendees
  * Support for OS customized text sizes
  * Send a message to participants in a waiting room
  * Merge participant's video and Audio
  * Hide non-video participants
  * Meeting reactions
  * View other participant's audio status
* Add support for the Korean language.


## Changed & Fixed:
* Enhanced security and upgraded OpenSSL to 1.0.2u.
* Optimized the screen share frame rate while in the meeting.
* Fixed an issue that the `-(void)onInMeetingChat` method gets triggered twice.
* Fixed an issue that the app sometimes crashes when clicking the participant list and then select a user on iPad.
* Fixed an issue that the video direction is incorrect while in the waiting room under customized UI mode.

## 2019-12-16 @ v4.4.57220.1211

## Added:
* Add new interfaces for SDK initialization with JWT token.
  * `@property (nullable, retain, nonatomic) NSString *jwtToken`
* Add new interfaces to access the virtual background.
  * The interfaces in `MobileRTCMeetingService+VirtualBackground.h`.
* Add new interfaces and callbacks for minimizing/resuming meeting.
  * `- (BOOL)showMinimizeMeetingFromZoomUIMeeting;`
  *  `- (BOOL)backZoomUIMeetingFromMinimizeMeeting;`
  * `- (void)onSinkMeetingShowMinimizeMeetingOrBackZoomUI:(MobileRTCMinimizeMeetingState)state;`
* Add new interfaces for the Q&A feature in the webinar.
  * The interfaces in `MobileRTCMeetingService+Webinar.h`
* Add a new interface to show/hide the "My Connected Time".
  * `- (BOOL)showMyMeetingElapseTime;`
  * `- (void)enableShowMyMeetingElapseTime:(BOOL)enable;`
* Add a new interface for users to get the meeting password while in the meeting.
  * `- (NSString *_Nullable)getMeetingPassword;`
* Add a callback to remind the user that free meeting will be ended in 10 minutes.
  * ` - (void)onFreeMeetingReminder:
       (BOOL)host
       canFreeUpgrade:(BOOL)freeUpgrade
       isFirstGift:(BOOL)first
       completion:(void (^_Nonnull)(BOOL upgrade))completion;`

## Changed & Fixed:
* Fixed an issue that the attendee cannot get the chat privilege.
* Fixed an issue that the meeting restarts for a few times after pressing the end meeting button.

## 2019-11-04 @ v4.4.56624.1028

## Added:
* Add a new interface to hide the "Disconnect Audio" button
* Add a new interface for SDK initialization
* Add a new interface to hide the Q&A button and the POLL button
* Add a new parameter in `presentMeetingChatViewController` to allow setting the chat as public or private

## Changed & Fixed:
* Updated all interfaces that involves `UIWebView` and removed `UIWebView` in SDK since Apple is deprecating `UIWebView`
* Fixed an issue that the SDK will crash by chance when doing a screen share
* Fixed some compatibility issues with iOS 13
* Fixed an issue that the Xcode is warning for `nullable` or `nonnull` in SDK
* Fixed an issue that the crash file was created when the app is being killed by the system
* Fixed an issue that the UI freeze when sharing a photo in landscape mode
* Fixed an issue that some users is not able to join the meeting when the `RootViewController` is not configured
* Fixed an issue that the host sees an error message when plugging SDK app into projector while in an active meeting
* Fixed an issue that some users see navigationBar in the default meeting UI

## Deprecated
* `(void)initializeWithDomain:(NSString * _Nonnull)domain enableLog:(BOOL)enableLog;`
* `(void)initializeWithDomain:(NSString * _Nonnull)domain enableLog:(BOOL)enableLog bundleResPath:(NSString *_Nullable)bundleResPath;`
* `(void)setMobileRTCDomain:(NSString * _Nonnull)domain;`
* `(void)setMobileRTCResPath:(NSString * _Nullable)path;`
* `(void)setAppGroupsName:(NSString * _Nullable)appGroupId;`

## 2019-09-04 @ v4.4.55968.0904

## Added
* Add iOS 13 and iPad OS support (Based on iOS beta 7, the latest beta version available at the time we published this release)
* Add a new interface to hide the "Chat" button in Zoom UI
* `- (void)setMeetingChatHidden:(BOOL)hidden;`
* Add a new interface to disable "Gallery View" in the meeting
* `- (void)disableGalleryView:(BOOL)disabled;`
* Add a new callback for notifying the host when the host requires attendants to unmute microphone
*  `- (void)onSinkMeetingAudioRequestUnmuteByHost; `
* Add a new parameter to `presentMeetingChatViewController` to allow passing userId and specify the person to chat with
* `- (BOOL)presentMeetingChatViewController:(nonnull UIViewController*)parentVC userId:(NSInteger)userId;`
* Add a new interface that allows users to modify default values to use handset mode
* `-(BOOL)speakerOffWhenInMeeting`
* `-(void)setSpeakerOffWhenInMeeting:(BOOL)speakerOff`

## Changed & Fixed
* Fixed an issue that sharing an invalid web URL will show black screen while in the meeting
* Fixed an issue that sending the pairing code will lead to error
* Fixed an issue that the video is turned off by default when starting a meeting with ZAK
* Fixed an issue that the "Minimize Meeting" button is not shown in Zoom UI for non-login users
* Improved the performance for sharing web pages in a meeting

## 2019-07-15 @ v4.4.55130.0712

**Added**

* Add new interfaces for using the dial-in feature with custom UI
  * `- (NSUInteger)getParticipantID;`
  * `- (nullable MobileRTCCallCountryCode *)getDialInCurrentCountryCode;`
  * `- (nullable NSArray *)getDialInAllCountryCodes;`
  * `- (nullable NSArray *)getDialInCallCodesWithCountryId:(nullable NSString *)countryId;`
  * `- (BOOL)dialInCall:(nullable NSString *)countryNumber;`
* Add a new interface to customize the end meeting pop-over window
  * `- (BOOL)onClickedEndButton:(UIViewController*)parentVC endButton:(UIButton *)endButton;`
* Add a new interface to enable/disable playing chime sound while joining/leaving a meeting
  * `- (BOOL)playChime:(BOOL)on;`
* Add a new interface to enable/disable “touch up my appearance” feature
  * `- (BOOL)faceBeautyEnabled;`
  *  `- (void)setFaceBeautyEnabled:(BOOL)enable;`
* Add a new interface to change the chat privilege of an attendee while in the meeting
  * `- (BOOL)changeAttendeeChatPriviledge:(MobileRTCMeetingChatPriviledgeType)type;`
  * `- (MobileRTCMeetingChatPriviledgeType)getAttendeeChatPriviledge;`
* Add a new interface to distinguish H.323 user and telephone user
  * `@property (nonatomic, assign) BOOL             isH323User;`
  * `@property (nonatomic, assign) BOOL             isPureCallInUser;`
* Add a new interface to enable/disable the “minimize meeting” feature
  * `- (BOOL)minimizeMeetingDisabled;`
  * `- (void)disableMinimizeMeeting:(BOOL)disabled;`
* Add audio sharing option in screen sharing, now you will be able to share the device audio in sharing your screen. Such as music, audio in a video, etc. (Not supported in Customize UI)


**Changed & Fixed**

* Improved the performance of UIView sharing
* Optimized the performance of sharing web view
* Changed the virtual background settings to follow the settings on the web portal
* Hide the “Invite your contacts to join this meeting” tip when the invite button is set to be hidden
* Fixed an issue that the “Invite by phone” shows no contact information
* Fixed an issue that the PMI number is not correctly fetched after scheduling a meeting for others
* Fixed an issue that the iOS status bar is blocking the shared content on iPad
* Fixed an issue that the screen share tip view is hidden while screen sharing
* Fixed an issue that the top bar is hidden while screen sharing
* Fixed an issue that the app crashes occasionally when setting domain
* Fixed an issue that switching between the gallery view and the speaker view will cause the app freeze on iPad

## 2019-03-25 @ v4.3.1.47201.0322

**Added**
* Introduce new Zoom meeting UI
* Start supporting Virtual Background feature
* Start supporting CallKit
* Start supporting minimize meeting
* Add new interfaces to control “disable viewer’s annotate” on the share sender site
* Add new interfaces to customize the sub-tab pages in H323 invite page and customize all tab pages in the invite dialog
* Add new interfaces for waiting room feature

**Changed & Fixed**

* Fix some issues that occasionally causes sharing failure
* Fix some issues that occasionally causes UI freezes
* Fix an issue that the onSinkMeetingUserLeft method does not call back
* Fix an issue that the local video data not shown when frequently start and stop meeting
* Improve the performance of screen sharing
* Fix an issue that the call-me prompts only heard in English
* Fix an issue that the participant list is not reflecting camera and microphone options

**Deprecated**

* - (void)setMobileRTCResPath:(NSString *)path;

## 2019-01-23 @ v4.3.0.30728.0118

**Added**
* New functional documentation.
* A new refactorized demo project that provides clear instructions on how to implement major features.
* New logging feature that stores logs with the maximum size of 5MB.
* New option for customizing internationalization string files
* A new method to join/start meeting directly via url, such as zoommtg://zoom.us/join?action=....
* Support to select dial-in country while scheduling a meeting.

**Changed & Fixed**
* An issue that turning off sharing the web does not work
* A case that some users’ avatars are not clear
* An issue that causes isWebinarMeeting function always return NO.
* Some performance issues with annotation feature
* An issue that the userId returned by different functional modules is inconsistent.
* Some issues that cause crashes

## 2018-10-24 @ v4.1.34076.1024

* Added support with Xcode 10;
* Added support for iPhone XS/XS MAX/XR;
* Added support to schedule meeting for a specified user;
* Added support to third party audio;
* Added support to specified a domain;
* Added support to only allow signed in user to join the meeting;
* Enhanced Custom Meeting UI feature;
* Enhanced meeting scheduling feature;
* Fixed audio quality issue on iPad Pro, iPhone X series devices, and iPhone 8;
* Fixed annotation crash on iOS 12;

## 2018-09-11 @ v4.1.32183.0910

* Schedule Meeting Feature Enhancement
* Bug fixes

## 2018-08-20 @ v4.1.30420.0817

* SDK Framework Interface Refactor, introduce MobileRTCMeetingService category cluster for specific Service Module:
1. MobileRTCMeetingService+Audio: Audio Service
2. MobileRTCMeetingService+Video: Video Service
3. MobileRTCMeetingService+Chat: Chat Service
4. MobileRTCMeetingService+User: User Service
5. MobileRTCMeetingService+Webinar: Webinar Service

* SDK Framework Delegate Refactor, introduce MobileRTCMeetingServiceDelegate cluster for event callback in the specific Service Module:
1. MobileRTCAudioServiceDelegate: Audio Service Delegate
2. MobileRTCVideoServiceDelegate: Video Service Delegate
3. MobileRTCUserServiceDelegate: User Service Delegate
4. MobileRTCShareServiceDelegate: Share Service Delegate
5. MobileRTCWebinarServiceDelegate: Webinar Service Delegate
6. MobileRTCCustomizedUIMeetingDelegate: Customized Meeting UI Delegate

* Custom Meeting UI (support basic meeting function, except for Webinar and Breakout Session)
1. Support Annotate for customized Meeting UI
2. Support Remote Control for customized Meeting UI

* Support In-meeting Chat related common feature
* Fix Annotate crash issue on iOS 12
* Support Webinar related common feature (do not support Q&A and Polling)
* Bug fixes

## 2018-07-26 @ v4.1.28989.0727

The start meeting logic for API users has changed. Please read below before upgrading to this version.

### Added

1. Security Enhancement: ZAK is necessary while Start Meeting for non-login user
old API User start meeting logic:
```
NSDictionary * paramDict = @{kMeetingParam_UserID:kSDKUserID,
                          kMeetingParam_UserToken:kSDKUserToken,
                          kMeetingParam_UserType:@(userType),
                          kMeetingParam_Username:kSDKUserName,
                          kMeetingParam_MeetingNumber:kSDKMeetNumber,
                          kMeetingParam_IsAppShare:@(appShare),
                          //kMeetingParam_ParticipantID:kParticipantID,
                          kMeetingParam_NoAudio:@(YES),
                          //kMeetingParam_NoVideo:@(YES),
                          };
MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
MobileRTCMeetError ret = [ms startMeetingWithDictionary:paramDict];
```

new API User start meeting logic:
```
MobileRTCMeetingStartParam * param = nil;

MobileRTCMeetingStartParam4WithoutLoginUser * user = [[[MobileRTCMeetingStartParam4WithoutLoginUser alloc]init] autorelease];
        user.userType = MobileRTCUserType_APIUser;
        user.meetingNumber = kSDKMeetNumber;
        user.userName = kSDKUserName;
        user.userToken = kSDKUserToken;
        user.userID = kSDKUserID;
        user.zak = kZAK;
        user.isAppShare = appShare;
        param = user;

MobileRTCMeetError ret = [ms startMeetingWithStartParam:param];

Note that: User need to be clear about your own Usertype,
Interface [[[MobileRTC sharedRTC] getAuthService] getUserType] would not return the correct Usertype.
```

2. Support iOS Screen share via Replaykit tech on iOS OS Version 11 and later(Usage Guide refer to MobileRTCSample/MobileRTCSampleScreenShare/iOS SDK Screen Share Extension Integration Guide.docx)

3. Support Add Customize the Invite Action Item into Invite ActionSheet. The original call back: - (void)onClickedInviteButton:(UIViewController*)parentVC has been deprecated, please use - (BOOL)onClickedInviteButton:(UIViewController*)parentVC addInviteActionItem:(NSMutableArray *)array instead;

4. Support Add Customize the Share Action Item into Share ActionSheet. The original call back: - (BOOL)onClickedShareButton has been deprecated, please use - (BOOL)onClickedShareButton:(UIViewController*)parentVC addShareActionItem:(NSMutableArray *)array instead.

5. Support Claim host with host key

6. Support Assgin & Revoke co-host & Check wether user can be co-host

7. Support Start Live Stream directly without Web Integration

8. Bug fixes

## 2018-05-28 @ v4.1.25402.0528

### Added

1. SDK Framework switch to Dynamic Library, MinimumOSVersion 8.0, Customer need to link SDK Framework as Embedded Binaries

2. Support to show/shrink attendees' video ribbon while viewing screen sharing for panelist in webinar meeting

3. Support to show/shrink active speaker' video ribbon while viewing screen sharing for attendee in webinar meeting

4. Support to query live stream URL & Start Live stream broadcast

5. Support to enable hide the full phone number for pure call in user

6. Add interfaces to allow a customer to show or hide In-Meeting UI View

7. Add interfaces to allow a customer to mute my video

8. Support to config DSCP for audio & video session

9. Bug fixes

## 2018-02-06
1. Support to show/shrink attendees' video ribbon while viewing screen sharing

2. Support to query network quality of video/audio/share in meeting

3. Add interfaces to allow customer to determine whether show share menu or not while clicking share button in meeting

4. Add interfaces to allow customer to determine whether show waiting HUD or not while starting&joining&leaving meeting

5. Bug fixes

### Added

## 2017-11-03

### Added
1. Support iOS 11 and iPhone X compatibility

2. Support SSO login

3. Add interfaces to get ongoing meeting topic, start time and repeat type

4. Add interfaces to check if meeting support inviting by phone and room system

5. Add interfaces to start/stop my audio&video , host start/stop attendees' audio

6. Add interfaces to allow to show thumbnail videos in the right side which viewing sharing

7. Add interfaces to schedule/edit/delete meeting after login with work email/SSO in mobileRTC

8. Bug fixes

## 2017-06-14

### Added
1. Add interface to get mobileRTC’s version

2. Add interface to set the path of mobileRTCResources.bundle

3. Add interface to get H.323/SIP IP Addresses for call in

4. Add interfaces to check "Invite by Phone" & "Invite H.323/SIP" or not

5. Bug fix

## 2017-03-03

### Added
1. Fix Signal SIGPIPE issue after losingWiFi connection;

2. Add interfaces to get attendees in meeting
(NSArray*)getInMeetingUserList;

3. Add delegate to get attendee state change
- (void)onMyAudioStateChange
- (void)onMyVideoStateChange
- (void)onMyHandStateChange
- (void)onAudioOutputChange
- (void)inMeetingUserUpdated

4. Add interfaces for Raise Hand, Spotlight Video, Make Host and Remove User
- (BOOL)raiseMyHand;
Example
- (void)onHandButtonClicked:(id)sender
{
	MobileRTCMeetingService *ms = [[MobileRTCsharedRTC] getMeetingService];
	if (ms )
		{
			MobileRTCMeetingUserInfo *my = [msgetMyUserInfo];
			if (my.handRaised)
				{
					[mslowerHand:my.userID];
				}
			else
				{
					[msraiseMyHand];
				}
		}
}

- (void)onMyHandStateChange
{
	NSLog(@"onMyHandStateChange");
}

- (BOOL)lowerHand:(NSUInteger)userId;
- (BOOL)lowerAllHand;
- [mslowerHand];
- (BOOL)isUserVideoPinned:(NSUInteger)userId;
- (BOOL)pinVideo:(BOOL)on withUser:(NSUInteger)userId;
- (BOOL)makeHost:(NSUInteger)userId;

5. Add interfaces to call room device directly
- (BOOL)isCallingRoomDevice;
- (BOOL)cancelCallRoomDevice;
- (NSArray*)getRoomDeviceList;
- (BOOL)sendPairingCode:(NSString*)code;
- (BOOL)callRoomDevice:(MobileRTCRoomDevice*)device;

## 2017-01-03

### Added
1. Support to join Webinar with Panelist member;

2. Add option to show/hide thumbnail video while viewing/starting
share in meeting;

3. Add option to hide “Leave Meeting” item in host side;

4. Add watermark in MobileRTC

## 2016-11-28

### Added
1. Ignore App Transport Security (ATS)

2. Integrate RTC with Xcode 8

## 2016-11-15

### Added
1. Add github address

2. Fix bug that username of active video does not change after
changing active video username in Participant list

3. Fix bug that alert message of microphone/camera privilege are
not localized.

## 2016-11-10

### Added
1. Fix bug that RTC should popup an alert while dialing out with an unsupported number

2. Fix bug that RTC should start meeting successfully after changing user to another user

## 2016-11-04

### Added
1. Rename “ZoomSDK.framework” to “MobileRTC.framework”

2. Rename “ZoomSDKResources.bundle” to “MobileRTCResources.bundle”

## 2016-10-08

### Added
1. Support to customize Dial-out

2. Change Interface “startMeeting:” to “startMeetingWithDictionary:”

3. Change Interface “joinMeeting:” to “joinMeetingWithDictionary”

## 2016-08-26

### Added
1. Support to customize strings in MobileRTC;

2. Support to customize images in MobileRTC

## 2016-08-11

### Added
1. Add Interface for login with work email;

2. Add Interface for login user to schedule/edit/delete/list meeting

## 2016-06-04

### Added
1. Add Interface “onAppShareSplash” in MobileRTCMeetingServiceDelegate for app share;

2. Add Interface “onJBHWaitingWithCmd:” in MobileRTCMeetingServiceDelegate for customizing to show/hide JBH waiting.

## 2016-01-15

### Added
1. Support to enable/disable "Invite by Email";

2. Support to customize the content and subject of "Invite by Email"
