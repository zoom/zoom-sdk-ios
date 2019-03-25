# CHANGELOG

## 2019-03-25 @ [v4.3.47201.0322](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.3.47201.0322)

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

## 2019-01-23 @ [v4.3.30728.0118](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.3.30728.0118)

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

## 2018-10-24 @ [v4.1.34076.1024](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.1.34076.1024)

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

## 2018-09-11 @ [v4.1.32183.0910](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.1.32183.0910)

* Schedule Meeting Feature Enhancement
* Bug fixes

## 2018-08-20 @ [v4.1.30420.0817](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.1.30420.0817)

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

## 2018-07-26 @ [v4.1.28989.0727](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.1.28989.0727)

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

## 2018-05-28 @ [v4.1.25402.0528](https://github.com/zoom/zoom-sdk-ios/releases/tag/v4.1.25402.0528)

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
