//
//  ManageLanInterpreViewController.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/10/22.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "ManageLanInterpreViewController.h"
#import "ManageLanInterpreTableViewCell.h"

@implementation SampleInterpreter

@end

@interface ManageLanInterpreViewController ()<UITableViewDataSource, UITableViewDelegate, onCellButtonClickedDelegate>
@property (nonatomic, strong)   UITableView           *tableView;
@property (nonatomic, strong)   NSMutableArray               *tableDataSource;
@property (nonatomic, strong)   NSMutableArray               *changeArray;
@property (nonatomic, strong)   NSMutableArray               *addArray;
@property (nonatomic, strong)   NSMutableArray               *deleteArray;
@end

@implementation ManageLanInterpreViewController
{
    UIButton *startEndBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Language Interpretation";
    
    NSArray *interpreterList = [[[MobileRTC sharedRTC] getMeetingService] getInterpreterList];
    self.tableDataSource = [[NSMutableArray alloc] init];
    self.changeArray = [[NSMutableArray alloc] init];
    self.addArray = [[NSMutableArray alloc] init];
    self.deleteArray = [[NSMutableArray alloc] init];
    
    for (MobileRTCMeetingInterpreter *item in interpreterList) {
        SampleInterpreter * interpreter = [[SampleInterpreter alloc] init];
        interpreter.userID = item.getUserID;
        interpreter.languageID1 = item.getLanguageID1;
        interpreter.languageID2 = item.getLanguageID2;
        interpreter.isAvailable = item.isAvailable;
        [self.tableDataSource addObject:interpreter];
        [interpreter release];
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"") style: UIBarButtonSystemItemDone target: self action: @selector(onDoneBtnClicked:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    [rightItem release];
    
    float h;
    if (IPHONE_X) {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - SAFE_ZOOM_INSETS;
    } else {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - 20;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h-50) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 140.f;
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
    [self.tableView registerClass:[ManageLanInterpreTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    
    UIButton *updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, h-45-20, (SCREEN_WIDTH-30-20)/3, 40)];
    [updateBtn setTitle:@"update" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor redColor] forState:0];
    updateBtn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    updateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [updateBtn addTarget: self action: @selector(updateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(updateBtn.frame)+10, h-45-20, (SCREEN_WIDTH-30-20)/3, 40)];
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor redColor] forState:0];
    addBtn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [addBtn addTarget: self action: @selector(addClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    startEndBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addBtn.frame)+10, addBtn.frame.origin.y, (SCREEN_WIDTH-30-20)/3, 40)];
    [startEndBtn setTitle:@"End" forState:UIControlStateNormal];
    [startEndBtn setTitleColor:[UIColor redColor] forState:0];
    startEndBtn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    startEndBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [startEndBtn addTarget: self action: @selector(startEndClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startEndBtn];
    
    if ([[[MobileRTC sharedRTC] getMeetingService] isInterpretationStarted]) {
        [startEndBtn setTitle:@"End" forState:UIControlStateNormal];
    } else {
        [startEndBtn setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)onDoneBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateClicked:(id)sender
{
    if (self.addArray.count > 0) {
        for (SampleInterpreter *interpreter in self.addArray) {
            [[[MobileRTC sharedRTC] getMeetingService] addInterpreter:interpreter.userID lan1:interpreter.languageID1 andLan2:interpreter.languageID2];
        }
        [self.addArray removeAllObjects];
    }
    
    if (self.changeArray.count > 0) {
        for (SampleInterpreter *interpreter in self.changeArray) {
            [[[MobileRTC sharedRTC] getMeetingService] modifyInterpreter:interpreter.userID lan1:interpreter.languageID1 andLan2:interpreter.languageID2];
        }
        [self.changeArray removeAllObjects];
    }
    
    if (self.deleteArray.count > 0) {
        for (SampleInterpreter *interpreter in self.deleteArray) {
            [[[MobileRTC sharedRTC] getMeetingService] removeInterpreter:interpreter.userID];
        }
        [self.deleteArray removeAllObjects];
    }
}

- (void)addClicked:(id)sender
{
    NSArray *allLans = [[[MobileRTC sharedRTC] getMeetingService] getAllLanguageList];
    NSInteger count = allLans.count;
    MobileRTCInterpretationLanguage *addLan1 = [allLans objectAtIndex:count-1];
    MobileRTCInterpretationLanguage *addLan2 = [allLans objectAtIndex:count-2];
    
    SampleInterpreter * interpreter = [[SampleInterpreter alloc] init];
    interpreter.userID = [[[MobileRTC sharedRTC] getMeetingService] myselfUserID];
    interpreter.languageID1 = addLan1.getLanguageID;
    interpreter.languageID2 = addLan2.getLanguageID;
    interpreter.isAvailable = YES;
    [self.tableDataSource addObject:interpreter];
    [self.addArray addObject:interpreter];
    [interpreter release];
    [self.tableView reloadData];
}

- (void)startEndClicked:(id)sender
{
    if ([[[MobileRTC sharedRTC] getMeetingService] isInterpretationStarted]) {
        BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] stopInterpretation];
        if (ret)
            [startEndBtn setTitle:@"Start" forState:UIControlStateNormal];
    } else {
        BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] startInterpretation];
        if (ret)
            [startEndBtn setTitle:@"End" forState:UIControlStateNormal];
    }
}

- (void)onCellButtonClicked:(UIButton *)sender rowIndex:(NSInteger)rowIndex
{
    NSLog(@"rowIndex======%@",@(rowIndex));
    SampleInterpreter *interpreter = [self.tableDataSource objectAtIndex:rowIndex];
    switch (sender.tag) {
        case kTagDeleteButton:
        {
            [self.deleteArray addObject:interpreter];
            [self.tableDataSource removeObject:interpreter];
            [self.tableView reloadData];
        }
            break;
        case kTagNameButton:
        
            break;
        case kTagLan1Button:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                         message:nil
                                                                                  preferredStyle:UIAlertControllerStyleActionSheet];

            NSArray *availableLanguageList  = [[[MobileRTC sharedRTC] getMeetingService] getAllLanguageList];

            for (int i = 0; i < availableLanguageList.count; i++) {
                MobileRTCInterpretationLanguage *lanItem = availableLanguageList[i];
                [alertController addAction:[UIAlertAction actionWithTitle:lanItem.getLanguageName
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction *action) {
                    interpreter.languageID1 = lanItem.getLanguageID;
                    [self.changeArray addObject:interpreter];
                    [self.tableView reloadData];
                    }]];
                    
            }
                
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];

            UIPopoverPresentationController *popover = alertController.popoverPresentationController;
            if (popover)
            {
            UIButton *btn = (UIButton*)sender;
            popover.sourceView = btn;
            popover.sourceRect = btn.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case kTagLan2Button:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                         message:nil
                                                                                  preferredStyle:UIAlertControllerStyleActionSheet];

            NSArray *availableLanguageList  = [[[MobileRTC sharedRTC] getMeetingService] getAllLanguageList];

            for (int i = 0; i < availableLanguageList.count; i++) {
                MobileRTCInterpretationLanguage *lanItem = availableLanguageList[i];
                [alertController addAction:[UIAlertAction actionWithTitle:lanItem.getLanguageName
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction *action) {
                    interpreter.languageID2 = lanItem.getLanguageID;
                    [self.changeArray addObject:interpreter];
                    [self.tableView reloadData];
                    }]];
            }
                
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];

            UIPopoverPresentationController *popover = alertController.popoverPresentationController;
            if (popover)
            {
            UIButton *btn = (UIButton*)sender;
            popover.sourceView = btn;
            popover.sourceRect = btn.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.tableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ManageLanInterpreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SampleInterpreter * interpreter = [self.tableDataSource objectAtIndex:indexPath.row];
    
    MobileRTCMeetingUserInfo *userInfo = [[[MobileRTC sharedRTC] getMeetingService] userInfoByID:interpreter.userID];
    cell.indexLabel.text = [NSString stringWithFormat:@"Interpreter %@", @(indexPath.row+1)];
    if (interpreter.isAvailable) {
        [cell.nameButton setTitle:userInfo.userName forState:0];
    } else {
        [cell.nameButton setTitle:@"not join" forState:0];
    }
    [cell.lan1Button setTitle:[self getLanguageNameByID:interpreter.languageID1] forState:0];
    [cell.lan2Button setTitle:[self getLanguageNameByID:interpreter.languageID2] forState:0];
    cell.rowIndex = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)getLanguageNameByID:(NSInteger)lanID {
    NSArray *languageArray = [[[MobileRTC sharedRTC] getMeetingService] getAllLanguageList];
    for (MobileRTCInterpretationLanguage * lan in languageArray) {
        if (lanID == lan.getLanguageID) {
            return lan.getLanguageName;
        }
    }
    return @"";
}
@end
