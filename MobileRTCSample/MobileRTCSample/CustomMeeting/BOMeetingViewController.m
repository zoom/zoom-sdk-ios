//
//  BOMeetingViewController.m
//  MobileRTCSample
//
//  Created by Jackie Chen on 2020/2/13.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "BOMeetingViewController.h"

typedef NS_ENUM(NSUInteger, BOActions) {
    // creator
    BOCreator_CreateBO = 100,
    BOCreator_UpdateBO,
    BOCreator_RemoveBO,
    BOCreator_AssignUserToBO,
    BOCreator_RemoveUser,
    
    // Admin
    BOAdmin_StartBO,
    BOAdmin_StopBO,
    BOAdmin_AssignNewUserToBO,
    BOAdmin_SwitchUser,
    BOAdmin_CanStartBO,
    
    // Assistant
    BOAssistant_JoinBO,
    BOAssistant_LeaveBO,
    
    // Attendee
    BOAttendee_JoinBO,
    BOAttendee_LeaveBO,
    BOAttendee_GetBOName,
    
    // BOData
    BODataHelper_UnsignedUserList,
    BODataHelper_BOMeetingIDList,
    BODataHelper_GetBOUser,
    BODataHelper_GetBOMeeting,
};

@interface BOMeetingViewController () <UITableViewDataSource, UITableViewDelegate, MobileRTCMeetingServiceDelegate>
@property (nonatomic, strong)   UITableView             *tableView;
@property (nonatomic, strong)   NSMutableArray          *dataSource;

@end

@implementation BOMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"BO Meeting";
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    [self.navigationItem.leftBarButtonItem setTintColor:RGBCOLOR(0x2D, 0x8C, 0xFF)];
    
    
    [[MobileRTC sharedRTC] getMeetingService].delegate = self;
    
    self.dataSource = [NSMutableArray array];
    [self initDataSource];
    [self initTableView];
}

- (void)dealloc {
    [_dataSource release];
    _dataSource = nil;
    [_tableView release];
    _tableView = nil;
    [super dealloc];
}

- (void)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)initDataSource
{
    [self.dataSource removeAllObjects];
        
    MobileRTCBOCreator *creator = [[[MobileRTC sharedRTC] getMeetingService] getCreatorHelper];
    if (creator) {
        [self.dataSource addObject:@(BOCreator_CreateBO)];
        [self.dataSource addObject:@(BOCreator_UpdateBO)];
        [self.dataSource addObject:@(BOCreator_RemoveBO)];
        [self.dataSource addObject:@(BOCreator_AssignUserToBO)];
        [self.dataSource addObject:@(BOCreator_RemoveUser)];
        
        NSLog(@"---BO--- Get Own Creator");
    }
    
    MobileRTCBOData *dataHelper = [[[MobileRTC sharedRTC] getMeetingService] getDataHelper];
    if (dataHelper) {
        [self.dataSource addObject:@(BODataHelper_UnsignedUserList)];
        [self.dataSource addObject:@(BODataHelper_BOMeetingIDList)];
        [self.dataSource addObject:@(BODataHelper_GetBOUser)];
        [self.dataSource addObject:@(BODataHelper_GetBOMeeting)];
        
        NSLog(@"---BO--- Get Own DataHelper");
    }
    
    MobileRTCBOAdmin *admin = [[[MobileRTC sharedRTC] getMeetingService] getAdminHelper];
    if (admin) {
        [self.dataSource addObject:@(BOAdmin_StartBO)];
        [self.dataSource addObject:@(BOAdmin_StopBO)];
        [self.dataSource addObject:@(BOAdmin_AssignNewUserToBO)];
        [self.dataSource addObject:@(BOAdmin_SwitchUser)];
        [self.dataSource addObject:@(BOAdmin_CanStartBO)];
        NSLog(@"---BO--- Get Own Admin");
    }
    
    MobileRTCBOAssistant *assistant = [[[MobileRTC sharedRTC] getMeetingService] getAssistantHelper];
    if (assistant) {
        [self.dataSource addObject:@(BOAssistant_JoinBO)];
        [self.dataSource addObject:@(BOAssistant_LeaveBO)];
        
        NSLog(@"---BO--- Get Own Assistant");
    }
    
    MobileRTCBOAttendee *attendee = [[[MobileRTC sharedRTC] getMeetingService] getAttedeeHelper];
    if (attendee) {
        [self.dataSource addObject:@(BOAttendee_JoinBO)];
        [self.dataSource addObject:@(BOAttendee_LeaveBO)];
        [self.dataSource addObject:@(BOAttendee_GetBOName)];
        
        NSLog(@"---BO--- Get Own Attendee");
    }
}

- (void)initTableView
{
    float h;
    if (IPHONE_X) {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - SAFE_ZOOM_INSETS;
    } else {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - 20;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero ];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedRowHeight = 0 ;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - MobileRTCMeetingServiceDelegate
- (void)onHasCreatorRightsNotification:(MobileRTCBOCreator *_Nonnull)creator
{
    NSLog(@"---BO--- Own Creator");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onHasAdminRightsNotification:(MobileRTCBOAdmin * _Nonnull)admin
{
    NSLog(@"---BO--- Own Admin");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onHasAssistantRightsNotification:(MobileRTCBOAssistant * _Nonnull)assistant
{
    NSLog(@"---BO--- Own Assistant");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onHasAttendeeRightsNotification:(MobileRTCBOAttendee * _Nonnull)attendee
{
    NSLog(@"---BO--- Own Attendee");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onHasDataHelperRightsNotification:(MobileRTCBOData * _Nonnull)dataHelper
{
    NSLog(@"---BO--- Own Data Helper");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onLostCreatorRightsNotification
{
    NSLog(@"---BO--- Lost Creator");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onLostAdminRightsNotification;
{
    NSLog(@"---BO--- Lost Admin");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onLostAssistantRightsNotification;
{
    NSLog(@"---BO--- Lost Assistant");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onLostAttendeeRightsNotification;
{
    NSLog(@"---BO--- Lost Attendee");
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)onLostDataHelperRightsNotification;
{
    NSLog(@"---BO--- Lost DataHelper");
    [self initDataSource];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSInteger index = [self.dataSource[indexPath.row] integerValue];
    NSString *cellName = [self getBOActionCaseName:index];
    cell.textLabel.text = cellName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = [self.dataSource[indexPath.row] integerValue];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIAlertController *alertController = nil;
    
    MobileRTCBOCreator *creator = [[[MobileRTC sharedRTC] getMeetingService] getCreatorHelper];
    MobileRTCBOData *dataHelper = [[[MobileRTC sharedRTC] getMeetingService] getDataHelper];
    MobileRTCBOAdmin *admin = [[[MobileRTC sharedRTC] getMeetingService] getAdminHelper];
    MobileRTCBOAssistant *assistant = [[[MobileRTC sharedRTC] getMeetingService] getAssistantHelper];
    MobileRTCBOAttendee *attendee = [[[MobileRTC sharedRTC] getMeetingService] getAttedeeHelper];
    
    switch (index) {
        case BOCreator_CreateBO:
        {
            if (!creator) {
                NSLog(@"no object");
                return;
            }
            NSDate *date = [NSDate date];
            NSString *boName = [NSString stringWithFormat:@"BO%@", @([date timeIntervalSince1970])];
            BOOL ret = [creator createBO:boName];
            NSLog(@"creator create BO: %@", ret? @"Success" : @"Fail");
            
            alertController = [UIAlertController alertControllerWithTitle:@"Create BO Name"
                                                                  message:boName
                                                           preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                style:UIAlertActionStyleCancel
                                                              handler:nil]];
        }
            break;
        case BOCreator_UpdateBO:
            {
                if (!creator || !dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                NSString *boId = [[dataHelper getBOMeetingIDList] firstObject];
                
                NSDate *date = [NSDate date];
                NSString *boName = [NSString stringWithFormat:@"BO%@", @([date timeIntervalSince1970])];
                BOOL ret = [creator updateBO:boId name:boName];
                NSLog(@"creator update BO: %@", ret? @"Success" : @"Fail");
                
                alertController = [UIAlertController alertControllerWithTitle:@"Update BO Name"
                                                                      message:[NSString stringWithFormat:@"Update Bo Name to:%@, Bo ID:%@",boName, boId]
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
                break;
        case BOCreator_RemoveBO:
            {
                if (!creator || !dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                NSArray *boArr = [dataHelper getBOMeetingIDList];
                
                alertController = [UIAlertController alertControllerWithTitle:@"Remove BO"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
                for (int i = 0; i < boArr.count; i++) {
                    NSString *boId = boArr[i];
                    MobileRTCBOMeeting *meeting = [dataHelper getBOMeetingByID:boId];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:meeting.getBOMeetingName
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                        BOOL ret = [creator removeBO:boId];
                        NSLog(@"creator remove BO: %@", ret? @"Success" : @"Fail");
                    }]];
                }
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil]];
            }
                break;
        case BOCreator_AssignUserToBO:
            {
                if (!creator || !dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                NSArray *unsignedUserArr = [dataHelper getUnassignedUserList];
                NSArray *meetingIDArr = [dataHelper getBOMeetingIDList];
                
                alertController = [UIAlertController alertControllerWithTitle:@"Assign all unsigned user to BO"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
                for (int i = 0; i < meetingIDArr.count; i++) {
                    NSString *boId = meetingIDArr[i];
                    MobileRTCBOMeeting *meeting = [dataHelper getBOMeetingByID:boId];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:meeting.getBOMeetingName
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                        for (int u = 0; u < unsignedUserArr.count; u++) {
                            NSString *userId = unsignedUserArr[u];
                            [creator assignUser:userId toBO:boId];
                        }
                    }]];
                }
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil]];
            }
            break;
        case BOCreator_RemoveUser:
            {
                if (!creator || !dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                
                NSArray *meetingIDArr = [dataHelper getBOMeetingIDList];
                
                alertController = [UIAlertController alertControllerWithTitle:@"Remove all user in one BO"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
                for (int i = 0; i < meetingIDArr.count; i++) {
                    NSString *boId = meetingIDArr[i];
                    MobileRTCBOMeeting *meeting = [dataHelper getBOMeetingByID:boId];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:meeting.getBOMeetingName
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                        NSArray *boUserList = [meeting getBOMeetingUserList];
                        for (int u = 0; u < boUserList.count; u++) {
                            NSString *userId = boUserList[u];
                            BOOL ret = [creator removeUser:userId fromBO:boId];
                            NSLog(@"creator remove user: %@", ret? @"Success" : @"Fail");
                        }
                    }]];
                }
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil]];
            }
            break;
            
        // Admin
        case BOAdmin_StartBO:
            {
                if (!admin) {
                    NSLog(@"no object");
                    return;
                }
                
                BOOL ret = [admin startBO];
                NSLog(@"Amdin start BO: %@", ret? @"Success" : @"Fail");
                
                alertController = [UIAlertController alertControllerWithTitle:@"Start BO"
                                                                      message:ret? @"Success" : @"Fail"
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        case BOAdmin_StopBO:
            {
                if (!admin) {
                    NSLog(@"no object");
                    return;
                }
                
                BOOL ret = [admin stopBO];
                NSLog(@"Amdin stop BO: %@", ret? @"Success" : @"Fail");
                
                alertController = [UIAlertController alertControllerWithTitle:@"Stop BO"
                                                                      message:ret? @"Success" : @"Fail"
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        case BOAdmin_AssignNewUserToBO:
            {
                if (!admin || !dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                
                NSArray *unsignedUserArr = [dataHelper getUnassignedUserList];
                NSArray *meetingIDArr = [dataHelper getBOMeetingIDList];
                
                alertController = [UIAlertController alertControllerWithTitle:@"Assign all unsigned user to BO"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
                for (int i = 0; i < meetingIDArr.count; i++) {
                    NSString *boId = meetingIDArr[i];
                    MobileRTCBOMeeting *meeting = [dataHelper getBOMeetingByID:boId];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:meeting.getBOMeetingName
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                        for (int u = 0; u < unsignedUserArr.count; u++) {
                            NSString *userId = unsignedUserArr[u];
                            BOOL ret = [admin assignNewUser:userId toRunningBO:boId];
                            NSLog(@"Amdin assign new user to BO: %@", ret? @"Success" : @"Fail");
                        }
                    }]];
                }
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil]];
            }
            break;
        case BOAdmin_SwitchUser:
            {
                if (!admin || !dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                NSArray *meetingArr = [dataHelper getBOMeetingIDList];
                if (meetingArr.count < 2) {
                    alertController = [UIAlertController alertControllerWithTitle:@"SwitchUser"
                                                                          message:@"only one bo"
                                                                   preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                        style:UIAlertActionStyleCancel
                                                                      handler:nil]];
                    return;
                }
                
                MobileRTCBOMeeting *fromBO = [dataHelper getBOMeetingByID:[meetingArr firstObject]];
                MobileRTCBOMeeting *toBO = [dataHelper getBOMeetingByID:[meetingArr lastObject]];
                
                NSString *fromUserId = [[fromBO getBOMeetingUserList] firstObject];
                MobileRTCBOUser *inBOUser = [dataHelper getBOUserByUserID:fromUserId];
                BOOL ret = [admin switchUser:fromUserId toRunningBO:[toBO getBOMeetingId]];
                NSLog(@"Amdin switch user: %@", ret? @"Success" : @"Fail");
                
                alertController = [UIAlertController alertControllerWithTitle:@"SwitchUser"
                                                                      message:[NSString stringWithFormat:@"switch %@ from %@ to %@: %@", inBOUser.getUserName, fromBO.getBOMeetingName, toBO.getBOMeetingName, ret? @"Success" : @"Fail"]
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
            
        case BOAdmin_CanStartBO:
            {
                if (!admin)
                    return;
                BOOL ret = [admin canStartBO];
                alertController = [UIAlertController alertControllerWithTitle:@"Can start BO by Admin?"
                                                                      message:ret ? @"Yes, You can" : @"No, you can't"
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        // Assistant
        case BOAssistant_JoinBO:
            {
                if (!assistant || !dataHelper ) {
                    NSLog(@"no object");
                    return;
                }
                                
                NSArray *meetingIDArr = [dataHelper getBOMeetingIDList];
                alertController = [UIAlertController alertControllerWithTitle:@"BOAssistant_JoinBO"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
                for (int i = 0; i < meetingIDArr.count; i++) {
                    NSString *boId = meetingIDArr[i];
                    MobileRTCBOMeeting *meeting = [dataHelper getBOMeetingByID:boId];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:meeting.getBOMeetingName
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                        [assistant joinBO:boId];
                    }]];
                }
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil]];
            }
            break;
        case BOAssistant_LeaveBO:
            {
                if (!assistant) {
                    NSLog(@"no object");
                    return;
                }
                
                BOOL ret = [assistant leaveBO];
                NSLog(@"assistant leave BO: %@", ret? @"Success": @"Fail");
                
                alertController = [UIAlertController alertControllerWithTitle:@"BOAssistant_LeaveBO"
                                                                      message:ret? @"Success": @"Fail"
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
            
            
        // Attendee
        case BOAttendee_JoinBO:
            {
                if (!attendee) {
                    NSLog(@"no object");
                    return;
                }
                
                BOOL ret = [attendee joinBO];
                NSLog(@"attendee join BO: %@", ret? @"Success": @"Fail");
                
                alertController = [UIAlertController alertControllerWithTitle:@"BOAttendee_JoinBO"
                                                                      message:ret? @"Success": @"Fail"
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        case BOAttendee_LeaveBO:
            {
                if (!attendee) {
                    NSLog(@"no object");
                    return;
                }
                
                BOOL ret = [attendee leaveBO];
                NSLog(@"attendee leave BO: %@", ret? @"Success": @"Fail");
                
                alertController = [UIAlertController alertControllerWithTitle:@"BOAttendee_LeaveBO"
                                                                      message:ret? @"Success": @"Fail"
                                                               preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        case BOAttendee_GetBOName:
            {
                if (!attendee) {
                    NSLog(@"no object");
                    return;
                }
                
                NSString *boName = [attendee getBOName];
                NSLog(@"attendee BO name: %@", boName);
                alertController = [UIAlertController alertControllerWithTitle:@"BOAttendee_GetBOName"
                                                                                         message:boName
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
            
        // BOData
        case BODataHelper_UnsignedUserList:
            {
                if (!dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                
                NSArray *arr = [dataHelper getUnassignedUserList];
                NSLog(@"datahelper un-assigned user: %@", [arr description]);
                
                alertController = [UIAlertController alertControllerWithTitle:@"BODataHelper_UnsignedUserList"
                                                                                         message:[arr description]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        case BODataHelper_BOMeetingIDList:
            {
                if (!dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                
                NSArray *arr = [dataHelper getBOMeetingIDList];
                NSLog(@"datahelper get bo meeting list: %@", [arr description]);
                alertController = [UIAlertController alertControllerWithTitle:@"BODataHelper_BOMeetingIDList"
                                                                                         message:[arr description]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        case BODataHelper_GetBOUser:
            {
                if (!dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                
                NSArray *unAssignUserArr = [dataHelper getUnassignedUserList];
                NSArray *meetingArr = [dataHelper getBOMeetingIDList];
                MobileRTCBOMeeting *meeting = [dataHelper getBOMeetingByID:[meetingArr firstObject]];
                NSString *inBOUserId = [[meeting getBOMeetingUserList] firstObject];
                
                MobileRTCBOUser *unassignboUser = [dataHelper getBOUserByUserID:[unAssignUserArr firstObject]];
                MobileRTCBOUser *inBOUser = [dataHelper getBOUserByUserID:inBOUserId];
                NSLog(@"datahelper bo unassign user: %@, in bo user: %@", [unassignboUser description], [inBOUser description]);
                
                alertController = [UIAlertController alertControllerWithTitle:@"BODataHelper_GetBOUser"
                                                                                         message:[NSString stringWithFormat:@"unassignboUser:%@,inBOUser:%@", [unassignboUser description], [inBOUser description]]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        case BODataHelper_GetBOMeeting:
            {
                if (!dataHelper) {
                    NSLog(@"no object");
                    return;
                }
                
                NSArray *meetingArr = [dataHelper getBOMeetingIDList];
                MobileRTCBOMeeting *meeting = [dataHelper getBOMeetingByID:[meetingArr firstObject]];
                
                NSLog(@"datahelper bo meeting: %@", [meeting description]);
                
                alertController = [UIAlertController alertControllerWithTitle:@"BODataHelper_GetBOMeeting"
                                                                                         message:[meeting description]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:nil]];
            }
            break;
        default:
            NSLog(@"not support now");
            break;
    }
    
    if (alertController) {
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = cell;
            popover.sourceRect = cell.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
    }
}

- (NSString *)getBOActionCaseName:(NSInteger)value {
    switch (value) {
        // creator
        case BOCreator_CreateBO:
            return @"BOCreator_CreateBO";
        case BOCreator_UpdateBO:
            return @"BOCreator_UpdateBO";
        case BOCreator_RemoveBO:
            return @"BOCreator_RemoveBO";
        case BOCreator_AssignUserToBO:
            return @"BOCreator_AssignUserToBO";
        case BOCreator_RemoveUser:
            return @"BOCreator_RemoveUser";
        
        // Admin
        case BOAdmin_StartBO:
            return @"BOAdmin_StartBO";
        case BOAdmin_StopBO:
            return @"BOAdmin_StopBO";
        case BOAdmin_AssignNewUserToBO:
            return @"BOAdmin_AssignNewUserToBO";
        case BOAdmin_SwitchUser:
            return @"BOAdmin_SwitchUser";
        case BOAdmin_CanStartBO:
            return @"BOAdmin_CanStartBO";
        
        // Assistant
        case BOAssistant_JoinBO:
            return @"BOAssistant_JoinBO";
        case BOAssistant_LeaveBO:
            return @"BOAssistant_LeaveBO";
        
        // Attendee
        case BOAttendee_JoinBO:
            return @"BOAttendee_JoinBO";
        case BOAttendee_LeaveBO:
            return @"BOAttendee_LeaveBO";
        case BOAttendee_GetBOName:
            return @"BOAttendee_GetBOName";
        
        // BOData
        case BODataHelper_UnsignedUserList:
            return @"BODataHelper_UnsignedUserList";
        case BODataHelper_BOMeetingIDList:
            return @"BODataHelper_BOMeetingIDList";
        case BODataHelper_GetBOUser:
            return @"BODataHelper_GetBOUser";
        case BODataHelper_GetBOMeeting:
            return @"BODataHelper_GetBOMeeting";
            
        default:
            return @"not support";
    }
}

@end
