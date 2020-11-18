//
//  InterpreterLanguageSelectViewController.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2020/10/27.
//  Copyright © 2020 Zoom Video Communications, Inc. All rights reserved.
//

#import "InterpreterLanguageSelectViewController.h"

@interface InterpreterLanguageSelectViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   UITableView           *tableView;
@property (nonatomic, strong)   NSArray        *tableDataSource;

@end

@implementation InterpreterLanguageSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Interpreter Language Select";

    self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getInterpreterLans];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MobileRTCInterpretationLanguage *language = [self.tableDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = language.getLanguageName;
    
    if(language.getLanguageID == [[[MobileRTC sharedRTC] getMeetingService] getInterpreterActiveLan])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MobileRTCInterpretationLanguage *language = [self.tableDataSource objectAtIndex:indexPath.row];
    BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] setInterpreterActiveLan:language.getLanguageID];
    if (ret) {
        for (UITableViewCell *cell in self.tableView.visibleCells) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
