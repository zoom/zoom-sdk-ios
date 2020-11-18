//
//  SelectLanInterpreViewController.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/10/22.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "SelectLanguageViewController.h"

@interface SelectLanguageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   UITableView           *tableView;
@property (nonatomic, strong)   NSMutableArray        *tableDataSource;

@end

@implementation SelectLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Language Interpretation";
    
    self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getAvailableLanguageList];
    
    float h;
    if (IPHONE_X) {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - SAFE_ZOOM_INSETS;
    } else {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - 20;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 44.f;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedRowHeight = 0 ;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    

    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"") style: UIBarButtonSystemItemDone target: self action: @selector(onDoneBtnClicked:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    [rightItem release];
}

- (void)onDoneBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_currentLanID == -1) {
        return self.tableDataSource.count + 1;
    }
    return self.tableDataSource.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"Original Audio";
        if(_currentLanID == -1)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    } else {
        if (_currentLanID == -1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            MobileRTCInterpretationLanguage *lan = [self.tableDataSource objectAtIndex:indexPath.row - 1];
            cell.textLabel.text = lan.getLanguageName;
            if(_currentLanID == lan.getLanguageID)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        } else {
            if (indexPath.row == self.tableDataSource.count + 1) {
                return [self enableOriginalAudioCell];
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                MobileRTCInterpretationLanguage *lan = [self.tableDataSource objectAtIndex:indexPath.row-1];
                cell.textLabel.text = lan.getLanguageName;
                if(_currentLanID == lan.getLanguageID)
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                else
                    cell.accessoryType = UITableViewCellAccessoryNone;
                return cell;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        _currentLanID = -1;
        [[[MobileRTC sharedRTC] getMeetingService] joinLanguageChannel:-1];
    } else {
        if (_currentLanID != -1 && indexPath.row == self.tableDataSource.count + 1) { // mute or unmute original audio
            return;
        }
        MobileRTCInterpretationLanguage *lan = [self.tableDataSource objectAtIndex:indexPath.row-1];
        [[[MobileRTC sharedRTC] getMeetingService] joinLanguageChannel:lan.getLanguageID];
        _currentLanID = lan.getLanguageID;
    }
    [self.tableView reloadData];
}

- (UITableViewCell*)enableOriginalAudioCell
{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = NSLocalizedString(@"Mute Original Audio", @"");
        
    UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    BOOL isMuteOriginal =  [[[MobileRTC sharedRTC] getMeetingService] isMajorAudioTurnOff];
    [sv setOn:isMuteOriginal animated:NO];
    [sv addTarget:self action:@selector(enableOriginal:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = sv;
    
    return cell;
}

- (void)enableOriginal:(id)sender
{
    BOOL isMuteOriginal =  [[[MobileRTC sharedRTC] getMeetingService] isMajorAudioTurnOff];
    if (isMuteOriginal) {
        [[[MobileRTC sharedRTC] getMeetingService] turnOnMajorAudio];
    } else {
        [[[MobileRTC sharedRTC] getMeetingService] turnOffMajorAudio];
    }
}
@end
