# CHANGELOG
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

