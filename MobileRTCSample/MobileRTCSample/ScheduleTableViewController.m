//
//  ScheduleTableViewController.m
//  MobileRTCSample
//
//  Created by Robust Hu on 2017/8/21.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "SDKScheduleMeetingPresenter.h"
#import <MobileRTC/MobileRTC.h>

#pragma mark - RTCDateInputTableViewCell
@class RTCDateInputTableViewCell;

@protocol RTCDateInputTableViewCellDelegate <NSObject>
@optional
- (void)tableViewCell:(RTCDateInputTableViewCell *)cell didEndEditingWithDate:(NSTimeInterval)value;
- (void)tableViewCell:(RTCDateInputTableViewCell *)cell didEndEditingWithDuration:(NSTimeInterval)value;
@end

@interface RTCDateInputTableViewCell : UITableViewCell
{
    UIToolbar *_inputAccessoryView;
}

@property (retain, nonatomic) UIDatePicker *datePicker;

@property (assign, nonatomic) NSInteger  minuteInterval;
@property (assign, nonatomic) UIDatePickerMode  modeValue;
@property (assign, nonatomic) NSTimeInterval    dateValue;
@property (assign, nonatomic) IBOutlet id<RTCDateInputTableViewCellDelegate> delegate;
@property (retain, nonatomic) NSTimeZone* timeZone;

@end

@implementation RTCDateInputTableViewCell

@synthesize timeZone;

- (void)initalizeInputView
{
    UIDatePicker* picker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    self.datePicker = picker;
    [picker release];
    
    _datePicker.backgroundColor  = [UIColor lightGrayColor];
    [_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [_datePicker setMinuteInterval:15];
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    CGRect frame = self.inputView.frame;
    frame.size = [self.datePicker sizeThatFits:CGSizeZero];
    self.inputView.frame = frame;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initalizeInputView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initalizeInputView];
    }
    return self;
}

- (void)dealloc
{
    [_inputAccessoryView release];
    [self setDatePicker:nil];
    [timeZone release];
    
    [super dealloc];
}

- (UIView *)inputView
{
    return self.datePicker;
}

- (UIView *)inputAccessoryView
{
    if (!_inputAccessoryView)
    {
        _inputAccessoryView = [[UIToolbar alloc] init];
        _inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
        _inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_inputAccessoryView sizeToFit];
        CGRect frame = _inputAccessoryView.frame;
        frame.size.height = 44.0f;
        _inputAccessoryView.frame = frame;
        
        UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBtn, nil];
        [_inputAccessoryView setItems:array];
        [flexibleSpaceLeft release];
        [doneBtn release];
    }
    
    return _inputAccessoryView;
}

- (void)done:(id)sender
{
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    if (self.datePicker.datePickerMode == UIDatePickerModeCountDownTimer)
    {
        [self.datePicker setCountDownDuration:_dateValue*60];
    }
    else
    {
        [self.datePicker setTimeZone:self.timeZone];
        [self.datePicker setDate:[NSDate dateWithTimeIntervalSince1970:_dateValue] animated:YES];
    }
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    id view = [self superview];
    
    while ([view isKindOfClass:[UITableView class]] == NO)
    {
        view = [view superview];
        if (!view)
            break;
    }
    
    if([view isKindOfClass:[UITableView class]] == YES)
    {
        UITableView *tableView = (UITableView *)view;
        NSIndexPath *indexPath = [tableView indexPathForCell:self];
        if (indexPath)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
    return [super resignFirstResponder];
}

- (void)setModeValue:(UIDatePickerMode)modeValue
{
    _modeValue = modeValue;
    [self.datePicker setDatePickerMode:modeValue];
    if (self.datePicker.datePickerMode == UIDatePickerModeDateAndTime)
    {
        [_datePicker setMinimumDate:[NSDate date]];
    }
    else
    {
        [_datePicker setMinuteInterval:15];
    }
}

- (void)setDateValue:(NSTimeInterval)value
{
    _dateValue = value;
    
    if (self.datePicker.datePickerMode == UIDatePickerModeCountDownTimer)
    {
        NSUInteger hour = (NSUInteger)value / 60;
        NSUInteger minute = (NSUInteger)value % 60;
        
        NSMutableString *formatDuration = [NSMutableString string];
        if (hour != 0)
        {
            [formatDuration appendFormat:@"%zd ", hour];
            [formatDuration appendString:(hour>1)?NSLocalizedString(@"hours", @""):NSLocalizedString(@"hour", @"")];
        }
        if (minute != 0)
        {
            [formatDuration appendFormat:@" %zd ", minute];
            [formatDuration appendString:(minute>1)?NSLocalizedString(@"mins", @""):NSLocalizedString(@"min", @"")];
        }
        
        self.detailTextLabel.text = formatDuration;
    }
    else
    {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDoesRelativeDateFormatting:YES];
        
        NSString *startTime = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        
        self.detailTextLabel.text = startTime;
    }

}

- (void)dateChanged:(id)sender
{
    if (self.datePicker.datePickerMode == UIDatePickerModeTime) {
        if ([_delegate respondsToSelector:@selector(tableViewCell:didEndEditingWithDate:)])
        {
            [_delegate tableViewCell:self didEndEditingWithDate:[((UIDatePicker *)sender).date timeIntervalSince1970]];
        }
    } else if (self.datePicker.datePickerMode == UIDatePickerModeCountDownTimer)
    {
        self.dateValue = ((UIDatePicker *)sender).countDownDuration/60;
        if ([_delegate respondsToSelector:@selector(tableViewCell:didEndEditingWithDuration:)])
        {
            [_delegate tableViewCell:self didEndEditingWithDuration:self.dateValue];
        }
    }
    else
    {
        self.dateValue = [((UIDatePicker *)sender).date timeIntervalSince1970];
        if ([_delegate respondsToSelector:@selector(tableViewCell:didEndEditingWithDate:)])
        {
            [_delegate tableViewCell:self didEndEditingWithDate:self.dateValue];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self becomeFirstResponder];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)setMinuteInterval:(NSInteger)minuteInterval
{
    [_datePicker setMinuteInterval:minuteInterval];
}

@end

#pragma mark - RTCTextFieldTableViewCell

@interface RTCTextFieldTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (retain, nonatomic) UITextField *textField;

@property (retain, nonatomic) NSString  *textValue;
@property (retain, nonatomic) NSString  *placeholder;
@property (assign, nonatomic) BOOL      secureText;

@end

@implementation RTCTextFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        [self initCellView];
    }
    return self;
}

- (void)dealloc
{
    self.textField.delegate = nil;
    self.textField = nil;
    
    [super dealloc];
}

- (void)initCellView
{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    
    UITextField *tmpTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField = tmpTextField;
    [tmpTextField release];
    
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.delegate = self;
    
    [self addSubview:self.textField];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        [self.textField becomeFirstResponder];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected)
    {
        [self.textField becomeFirstResponder];
    }
}

- (void)setTextValue:(NSString *)value
{
    self.textField.text = value;
}

- (NSString *)textValue
{
    return self.textField.text;
}

- (void)setSecureText:(BOOL)secure
{
    self.textField.secureTextEntry = secure;
}

- (BOOL)secureText
{
    return self.textField.secureTextEntry;
}

- (void)setPlaceholder:(NSString *)value
{
    self.textField.placeholder = value;
}

- (NSString *)placeholder
{
    return self.textField.placeholder;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    id view = [self superview];
    
    while ([view isKindOfClass:[UITableView class]] == NO)
    {
        view = [view superview];
        if (!view)
            break;
    }
    
    if([view isKindOfClass:[UITableView class]] == YES)
    {
        UITableView *tableView = (UITableView *)view;
        NSIndexPath *indexPath = [tableView indexPathForCell:self];
        if (indexPath)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentFrame;
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0)
        contentFrame = CGRectInset(self.contentView.frame, 15, 10);
    else
        contentFrame = CGRectInset(self.contentView.frame, 10, 10);
    
    self.textField.frame = contentFrame;
}

@end

#pragma mark - ScheduleTableViewController

@interface ScheduleTableViewController ()<RTCDateInputTableViewCellDelegate>

@property (retain, nonatomic) RTCTextFieldTableViewCell *topicCell;
@property (retain, nonatomic) RTCDateInputTableViewCell *startTimeCell;
@property (retain, nonatomic) RTCDateInputTableViewCell *durationCell;
@property (retain, nonatomic) RTCTextFieldTableViewCell *timezoneCell;
@property (retain, nonatomic) UITableViewCell *repeatCell;
@property (retain, nonatomic) UITableViewCell *usePMICell;
@property (retain, nonatomic) UITableViewCell *hostVideoCell;
@property (retain, nonatomic) UITableViewCell *attendeeVideoCell;
@property (retain, nonatomic) UITableViewCell *jbhCell;
@property (retain, nonatomic) UITableViewCell *waitingRoomCell;
@property (retain, nonatomic) UITableViewCell *publicListCell;

@property (retain, nonatomic) RTCTextFieldTableViewCell *pwdCell;
@property (retain, nonatomic) UITableViewCell *audioCell;

@property (retain, nonatomic) NSArray *itemArray;

@property (assign, nonatomic) NSTimeInterval        startTime;
@property (assign, nonatomic) NSUInteger            duration;
@property (assign, nonatomic) MeetingRepeat         repeat;
@property (assign, nonatomic) BOOL                  hostVideoOn;
@property (assign, nonatomic) BOOL                  attendeeVideoOn;
@property (assign, nonatomic) BOOL                  usePMI;
@property (assign, nonatomic) BOOL                  jbh;
@property (assign, nonatomic) BOOL                  waitingRoom;
@property (assign, nonatomic) BOOL                  publicList;


@property (assign, nonatomic) BOOL                  voipOff;
@property (assign, nonatomic) BOOL                  telephoneOff;

@property (retain, nonatomic) UITableViewCell *scheduleForCell;
@property (retain, nonatomic) NSArray * scheduleForList;
@property (retain, nonatomic) MobileRTCAlternativeHost * scheduleForUser;

@property (assign, nonatomic) BOOL                  onlyallowsignuserjoin;
@property (retain, nonatomic) UITableViewCell *     onlyallowsignuserjoinCell;

@property (assign, nonatomic) MobileRTCMeetingItemRecordType defaultRecordType;
@property (retain, nonatomic) UITableViewCell *     recordCell;

@property (retain, nonatomic) SDKScheduleMeetingPresenter *schedulePresenter;

@property (retain, nonatomic) MobileRTCDialinCountry *dialInCounty;
@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = NSLocalizedString(@"Schedule Meeting", @"");

    UIBarButtonItem *scheduleItem = [[UIBarButtonItem alloc] initWithTitle:@"Schedule" style:UIBarButtonItemStylePlain target:self action:@selector(onSchedule:)];
    self.navigationItem.rightBarButtonItem = scheduleItem;
    [scheduleItem release];

    [self initMeetingItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSchedule:(id)sender
{
    NSString *topic = self.topicCell.textValue;
    if ([topic length] == 0)
        return;
    
    id<MobileRTCMeetingItem> item = [[[MobileRTC sharedRTC] getPreMeetingService] createMeetingItem];
    [item setMeetingTopic:topic];
    [item setStartTime:[NSDate dateWithTimeIntervalSince1970:self.startTime]];
    [item setDurationInMinutes:self.duration];
    [item setTimeZoneID:self.timezoneCell.textValue];
    [item setMeetingRepeat:self.repeat];
    [item turnOffVideoForHost:!self.hostVideoOn];
    [item turnOffVideoForAttendee:!self.attendeeVideoOn];
    [item setUsePMIAsMeetingID:self.usePMI];
    [item setAllowJoinBeforeHost:self.jbh];
    [item enableWaitingRoom:self.waitingRoom];
    [item enableMeetingToPublic:self.publicList];
    [item setOnlyAllowSignedInUserJoinMeeting:self.onlyallowsignuserjoin];
    
//    [item enableLanguageInterpretation:YES]; // the setting only for the meeting that's not a pmi meeting

//    MobileRTCAlternativeHostInfo *aternativeHost1 = [[MobileRTCAlternativeHostInfo alloc] init];
//    aternativeHost1.email = @"";
//    MobileRTCAlternativeHostInfo *aternativeHost2 = [[MobileRTCAlternativeHostInfo alloc] init];
//    aternativeHost2.email = @"";
//    NSArray *array = @[aternativeHost1, aternativeHost2];
//    [item setAlternativeHostList:array];
    
    if (!self.voipOff && !self.telephoneOff)
    {
        [item setAudioOption:MobileRTCMeetingItemAudioType_TelephoneAndVoip];
    }
    else
    {
        if (!self.voipOff)
        {
            [item setAudioOption:MobileRTCMeetingItemAudioType_VoipOnly];
        }
        else if(!self.telephoneOff)
        {
            [item setAudioOption:MobileRTCMeetingItemAudioType_TelephoneOnly];
        }
    }
    [item setAvailableDialinCountry:self.dialInCounty];

    NSString *password = self.pwdCell.textValue;
    if ([password length] > 0) {
        [item setMeetingPassword:password];
    }
    
    NSString * email = self.scheduleForUser!=nil ? [self.scheduleForUser email] : nil;
    
    [item setRecordType:self.defaultRecordType];
    
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
    if (authService)
    {
        MobileRTCAccountInfo * account = [authService getAccountInfo];
        
        if (account)
        {
            [item setSpecifiedDomain:nil];
        }
    }
    
    if ([self.schedulePresenter scheduleMeeting:item WithScheduleFor:email]) {
        
        [self.schedulePresenter deleteMeeting:item];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
    
    [[[MobileRTC sharedRTC] getPreMeetingService] destroyMeetingItem:item];
}

- (void)initMeetingItems
{
    self.dialInCounty = [[[MobileRTC sharedRTC] getPreMeetingService] getAvailableDialInCountry];
    
    MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
    if (authService)
    {
        MobileRTCAccountInfo * account = [authService getAccountInfo];
        if (account)
        {
            self.scheduleForList = [account getCanScheduleForUsersList];
            self.onlyallowsignuserjoin = [account onlyAllowSignedInUserJoinMeeting];
            self.defaultRecordType = [account getDefaultAutoRecordType];
            
            if ([account isSpecifiedDomainCanJoinFeatureOn])
            {
                NSLog(@"isSpecifiedDomainCanJoinFeatureOn %d", [account isSpecifiedDomainCanJoinFeatureOn]);
                
                NSArray * array = [account getDefaultCanJoinUserSpecifiedDomains];
                for (NSString * item in array)
                {
                    NSLog(@"%@", item);
                }
            }
        }
    }
    
    self.startTime = [[NSDate date] timeIntervalSince1970];
    self.duration = 60;
    self.hostVideoOn = YES;
    self.attendeeVideoOn = YES;
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:@[[self topicCell]]];

    [array addObject:@[[self startTimeCell], [self durationCell], [self timezoneCell], [self repeatCell]]];
    
    [array addObject:@[[self hostVideoCell], [self attendeeVideoCell], [self usePMICell], [self jbhCell], [self waitingRoomCell], [self publicListCell]]];
    
    [array addObject:@[[self audioCell], [self pwdCell], [self onlyallowsignuserjoinCell]]];
    
    if (self.scheduleForList && [self.scheduleForList count] != 0)
    {
        [array addObject:@[[self scheduleForCell]]];
    }
    
    if (self.defaultRecordType != MobileRTCMeetingItemRecordType_AutoRecordDisabled)
    {
        [array addObject:@[[self recordCell]]];
    }
    
    self.itemArray = array;
    
    [self.tableView reloadData];
}

#pragma mark - Table view Cell

- (RTCTextFieldTableViewCell*)topicCell
{
    if (!_topicCell)
    {
        _topicCell = [[RTCTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _topicCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_topicCell setPlaceholder:@"Meeting Topic"];
    }
    
    return _topicCell;
}

- (RTCDateInputTableViewCell*)startTimeCell
{
    if (!_startTimeCell)
    {
        _startTimeCell = [[RTCDateInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _startTimeCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        _startTimeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _startTimeCell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        _startTimeCell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _startTimeCell.delegate = self;
        
        _startTimeCell.modeValue = UIDatePickerModeDateAndTime;
        
        NSString *text = NSLocalizedString(@"Starts", @"");
        _startTimeCell.textLabel.text = text;
    }
    
    _startTimeCell.timeZone = [NSTimeZone localTimeZone];
    _startTimeCell.dateValue = self.startTime;
    
    return _startTimeCell;
}

- (RTCDateInputTableViewCell*)durationCell
{
    if (!_durationCell)
    {
        _durationCell = [[RTCDateInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _durationCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        _durationCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _durationCell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        _durationCell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _durationCell.delegate = self;
        
        _durationCell.modeValue = UIDatePickerModeCountDownTimer;
        
        NSString *text = NSLocalizedString(@"Duration", @"");
        _durationCell.textLabel.text = text;
    }
    
    NSTimeInterval dateValue = self.duration;
    _durationCell.dateValue = dateValue;
    
    return _durationCell;
}

- (RTCTextFieldTableViewCell*)timezoneCell
{
    if (!_timezoneCell)
    {
        _timezoneCell = [[RTCTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _timezoneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _timezoneCell.textField.textAlignment = NSTextAlignmentRight;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        label.text = NSLocalizedString(@"Timezone", @"");
        CGSize size = CGSizeMake((self.tableView.frame.size.width-200.0), self.tableView.frame.size.height);
        label.frame = CGRectMake(0, 0, ceilf(size.width), ceilf(size.height));
        
        _timezoneCell.textField.leftViewMode = UITextFieldViewModeAlways;
        _timezoneCell.textField.leftView = label;
        [label release];

        
        NSTimeZone *tz = [NSTimeZone localTimeZone];
        _timezoneCell.textValue = [tz name];
    }
    
    return _timezoneCell;
}

- (UITableViewCell*)repeatCell
{
    if (!_repeatCell)
    {
        _repeatCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _repeatCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _repeatCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _repeatCell.textLabel.text = NSLocalizedString(@"Repeat", @"");
    }
    
    NSString *detailText = @"None";
    switch (self.repeat)
    {
        case MeetingRepeat_EveryDay:
            detailText = @"Every Day";
            break;
        case MeetingRepeat_EveryWeek:
            detailText = @"Every Week";
            break;
        case MeetingRepeat_Every2Weeks:
            detailText = @"Every 2 Weeks";
            break;
        case MeetingRepeat_EveryMonth:
            detailText = @"Every Month";
            break;
        case MeetingRepeat_EveryYear:
            detailText = @"Every Year";
            break;
            
        default:
            break;
    }
    _repeatCell.detailTextLabel.text = detailText;
    
    return _repeatCell;
}

- (UITableViewCell*)usePMICell
{
    if (!_usePMICell)
    {
        _usePMICell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _usePMICell.selectionStyle = UITableViewCellSelectionStyleNone;
        _usePMICell.textLabel.text = NSLocalizedString(@"Use PMI", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:self.usePMI animated:NO];
        [sv addTarget:self action:@selector(onUsePMI:) forControlEvents:UIControlEventValueChanged];
        _usePMICell.accessoryView = sv;
    }
    
    return _usePMICell;
}

- (void)onUsePMI:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    self.usePMI = sv.on;
}

- (UITableViewCell*)hostVideoCell
{
    if (!_hostVideoCell)
    {
        _hostVideoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _hostVideoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _hostVideoCell.textLabel.text = NSLocalizedString(@"Host Video On", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:self.hostVideoOn animated:NO];
        [sv addTarget:self action:@selector(onHostVideo:) forControlEvents:UIControlEventValueChanged];
        _hostVideoCell.accessoryView = sv;
    }
    
    return _hostVideoCell;
}

- (void)onHostVideo:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    self.hostVideoOn = sv.on;
}

- (UITableViewCell*)attendeeVideoCell
{
    if (!_attendeeVideoCell)
    {
        _attendeeVideoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _attendeeVideoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _attendeeVideoCell.textLabel.text = NSLocalizedString(@"Attendee Video On", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:self.attendeeVideoOn animated:NO];
        [sv addTarget:self action:@selector(onAttendeeVideo:) forControlEvents:UIControlEventValueChanged];
        _attendeeVideoCell.accessoryView = sv;
    }
    
    return _attendeeVideoCell;
}

- (void)onAttendeeVideo:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    self.attendeeVideoOn = sv.on;
}

- (UITableViewCell*)jbhCell
{
    if (!_jbhCell)
    {
        _jbhCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _jbhCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _jbhCell.textLabel.text = NSLocalizedString(@"Join Before Host", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:self.jbh animated:NO];
        [sv addTarget:self action:@selector(onJoinBeforeHost:) forControlEvents:UIControlEventValueChanged];
        _jbhCell.accessoryView = sv;
    }
    
    return _jbhCell;
}

- (void)onJoinBeforeHost:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    self.jbh = sv.on;
}

- (UITableViewCell*)waitingRoomCell
{
    if (!_waitingRoomCell)
    {
        _waitingRoomCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _waitingRoomCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _waitingRoomCell.textLabel.text = NSLocalizedString(@"Enable Waiting Room", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:self.waitingRoom animated:NO];
        [sv addTarget:self action:@selector(onWaitingRoomEnable:) forControlEvents:UIControlEventValueChanged];
        _waitingRoomCell.accessoryView = sv;
    }
    
    return _waitingRoomCell;
}

- (void)onWaitingRoomEnable:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    self.waitingRoom = sv.on;
}

- (UITableViewCell*)publicListCell
{
    if (!_publicListCell)
    {
        _publicListCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _publicListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _publicListCell.textLabel.text = NSLocalizedString(@"List in the Public Event List", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:self.publicList animated:NO];
        [sv addTarget:self action:@selector(onPublicListEnable:) forControlEvents:UIControlEventValueChanged];
        _publicListCell.accessoryView = sv;
    }
    
    return _publicListCell;
}

- (void)onPublicListEnable:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    self.publicList = sv.on;
}

- (RTCTextFieldTableViewCell*)pwdCell
{
    if (!_pwdCell)
    {
        _pwdCell = [[RTCTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _pwdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_pwdCell setPlaceholder:@"Meeting Password(optional)"];
    }
    
    return _pwdCell;
}

- (UITableViewCell*)audioCell
{
    if (!_audioCell)
    {
        _audioCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _audioCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _audioCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _audioCell.textLabel.text = NSLocalizedString(@"Audio Option", @"");
    }
    
    NSString *detailText = nil;
    if (!self.voipOff && !self.telephoneOff)
    {
        detailText = @"Telephone & Voip";
    }
    else if (!self.voipOff)
    {
        detailText = @"Voip";
    }
    else if (!self.telephoneOff)
    {
        detailText = @"Telephone";
    }
    
    _audioCell.detailTextLabel.text = detailText;
    
    return _audioCell;
}


- (UITableViewCell*)scheduleForCell
{
    if (!_scheduleForCell)
    {
        _scheduleForCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _scheduleForCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _scheduleForCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _scheduleForCell.textLabel.text = NSLocalizedString(@"Schedule For", @"");
    }
    
    return _scheduleForCell;
}

- (UITableViewCell*)onlyallowsignuserjoinCell
{
    if (!_onlyallowsignuserjoinCell)
    {
        _onlyallowsignuserjoinCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _onlyallowsignuserjoinCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _onlyallowsignuserjoinCell.textLabel.text = NSLocalizedString(@"Only Sign-in User Can Join the Meeting", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:self.onlyallowsignuserjoin animated:NO];
        [sv addTarget:self action:@selector(onOnlyAllowSignUserJoin:) forControlEvents:UIControlEventValueChanged];
        _onlyallowsignuserjoinCell.accessoryView = sv;
    }
    
    return _onlyallowsignuserjoinCell;
}

- (void)onOnlyAllowSignUserJoin:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    self.onlyallowsignuserjoin = sv.on;
}


- (UITableViewCell*)recordCell
{
    if (!_recordCell)
    {
        _recordCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _recordCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _recordCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _recordCell.textLabel.text = NSLocalizedString(@"Meeting Record", @"");
        
        if (self.defaultRecordType == MobileRTCMeetingItemRecordType_LocalRecord)
        {
            _recordCell.detailTextLabel.text = @"Local Record";
        }
        
        else if(self.defaultRecordType == MobileRTCMeetingItemRecordType_CloudRecord)
        {
            _recordCell.detailTextLabel.text = @"Cloud Record";
        }
        
        else if(self.defaultRecordType == MobileRTCMeetingItemRecordType_AutoRecordDisabled)
        {
            _recordCell.detailTextLabel.text = @"Do not Record";
        }
    }
    
    return _recordCell;
}

- (SDKScheduleMeetingPresenter *)schedulePresenter
{
    if (!_schedulePresenter) {
        _schedulePresenter = [[SDKScheduleMeetingPresenter alloc] init];
    }
    return _schedulePresenter;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.itemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.itemArray[section];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = self.itemArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = self.itemArray[indexPath.section][indexPath.row];
    if (cell == _repeatCell)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"None", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.repeat = MeetingRepeat_None;
                [self repeatCell];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Everyday", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.repeat = MeetingRepeat_EveryDay;
                [self repeatCell];
           }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Every Week", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.repeat = MeetingRepeat_EveryWeek;
                [self repeatCell];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Every 2 Weeks", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.repeat = MeetingRepeat_Every2Weeks;
                [self repeatCell];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Every Month", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.repeat = MeetingRepeat_EveryMonth;
                [self repeatCell];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Every Year", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.repeat = MeetingRepeat_EveryYear;
                [self repeatCell];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
           }]];
            
            UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
            popPresenter.sourceView = cell.detailTextLabel;
            popPresenter.sourceRect = cell.detailTextLabel.bounds;
            [self presentViewController:alertController animated:YES completion:nil];
        }
        return;
    }
    
    if (cell == _audioCell)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Telephone & Voip", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.voipOff = NO;
                self.telephoneOff = NO;
                [self audioCell];
                [self dialInCountryAlertInView:cell];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Voip", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.voipOff = NO;
                self.telephoneOff = YES;
                [self audioCell];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Telephone", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.voipOff = YES;
                self.telephoneOff = NO;
                [self audioCell];
                [self dialInCountryAlertInView:cell];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            
            UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
            popPresenter.sourceView = cell.detailTextLabel;
            popPresenter.sourceRect = cell.detailTextLabel.bounds;
            [self presentViewController:alertController animated:YES completion:nil];
        }
        return;
    }
    
    if (cell == _scheduleForCell)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && self.scheduleForList && [self.scheduleForList count] != 0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            for (MobileRTCAlternativeHost * host in self.scheduleForList)
            {
                [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ %@",[host firstName],[host lastName]] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    self.scheduleForCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[host firstName],[host lastName]];
                    self.scheduleForUser = host;
                }]];
            }
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
           
            UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
            popPresenter.sourceView = cell.detailTextLabel;
            popPresenter.sourceRect = cell.detailTextLabel.bounds;
            [self presentViewController:alertController animated:YES completion:nil];
        }
        return;
    }
    
    if (cell == _recordCell)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && self.scheduleForList && [self.scheduleForList count] != 0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
            if (authService)
            {
                MobileRTCAccountInfo * account = [authService getAccountInfo];
                if (account)
                {
                    if ([account isCloudRecordingSupported])
                    {
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Cloud Record" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            self.recordCell.detailTextLabel.text = @"Cloud Record";
                            self.defaultRecordType = MobileRTCMeetingItemRecordType_CloudRecord;
                        }]];
                    }
                    
                    if ([account isLocalRecordingSupported])
                    {
                        [alertController addAction:[UIAlertAction actionWithTitle:@"Local Record" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            self.recordCell.detailTextLabel.text = @"Local Record";
                            self.defaultRecordType = MobileRTCMeetingItemRecordType_LocalRecord;
                        }]];
                    }
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Do not Record" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        self.recordCell.detailTextLabel.text = @"Do not Record";
                        self.defaultRecordType = MobileRTCMeetingItemRecordType_AutoRecordDisabled;
                    }]];
                    
                }
            }
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            
            UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
            popPresenter.sourceView = cell.detailTextLabel;
            popPresenter.sourceRect = cell.detailTextLabel.bounds;
            [self presentViewController:alertController animated:YES completion:nil];
        }
        return;
    }
    
}

- (void)dialInCountryAlertInView:(UIView *)sourceView {
    if (self.dialInCounty.allCountries.count == 0) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Call In Country"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *countryStr in self.dialInCounty.allCountries) {
        if ([self.dialInCounty.selectedCountries containsObject:countryStr]) {
            [alertController addAction:[UIAlertAction actionWithTitle:[countryStr stringByAppendingString:@"✅"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.dialInCounty.selectedCountries removeObject:countryStr];
            }]];
        } else {
            [alertController addAction:[UIAlertAction actionWithTitle:countryStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.dialInCounty.selectedCountries addObject:countryStr];
            }]];
        }
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
    popPresenter.sourceView = sourceView;
    popPresenter.sourceRect = sourceView.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Date Delegate

- (void)tableViewCell:(RTCDateInputTableViewCell *)cell didEndEditingWithDate:(NSTimeInterval)value
{
    self.startTime = value;
}

- (void)tableViewCell:(RTCDateInputTableViewCell *)cell didEndEditingWithDuration:(NSTimeInterval)value
{
    self.duration = value;
}

@end
