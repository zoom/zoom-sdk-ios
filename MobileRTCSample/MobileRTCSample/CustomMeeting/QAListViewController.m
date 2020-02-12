//
//  QAListViewController.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2019/10/28.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import "QAListViewController.h"
#import "QAListTableViewCell.h"

typedef NS_ENUM(NSInteger, ZoomSampleQAListType) {
    ZoomSampleQAListType_All      = 0,
    ZoomSampleQAListType_My,
    ZoomSampleQAListType_Open,
    ZoomSampleQAListType_Answered,
    ZoomSampleQAListType_Dismissed,
};

@interface QAListViewController()<UITableViewDataSource, UITableViewDelegate, MobileRTCMeetingServiceDelegate>

@property (nonatomic, strong)   UITableView           *tableView;
@property (nonatomic, strong)   NSArray               *tableDataSource;
@property (nonatomic, assign)   ZoomSampleQAListType  type;
@end

@implementation QAListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.navigationController.navigationBar.translucent = NO;
    
    [[MobileRTC sharedRTC] getMeetingService].delegate = self;
    
    self.title = @"QA List";
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    [self.navigationItem.leftBarButtonItem setTintColor:RGBCOLOR(0x2D, 0x8C, 0xFF)];
    
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd:)];
    [self.navigationItem setRightBarButtonItem:moreItem];
    [self.navigationItem.rightBarButtonItem setTintColor:RGBCOLOR(0x2D, 0x8C, 0xFF)];
    
    float h;
    if (IPHONE_X) {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - SAFE_ZOOM_INSETS;
    } else {
        h = SCREEN_HEIGHT-self.navigationController.navigationBar.frame.size.height - 20;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 230;
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
    [self.tableView registerClass:[QAListTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    if ([[[MobileRTC sharedRTC] getMeetingService] isWebinarAttendee]) {
        self.type = ZoomSampleQAListType_All;
        self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getAllQuestionList];
    } else {
        self.type = ZoomSampleQAListType_Open;
        self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getOpenQuestionList];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)onAdd:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    if ([[[MobileRTC sharedRTC] getMeetingService] isWebinarAttendee]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Add Question"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [[[MobileRTC sharedRTC] getMeetingService] addQuestion:@"Test-Add-Qestion" anonymous:NO];
                                                          }]];
    }
    
    if ([[[MobileRTC sharedRTC] getMeetingService] isWebinarAttendee]) {
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"All Questions(%@)",@([[[MobileRTC sharedRTC] getMeetingService] getALLQuestionCount])]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.type = ZoomSampleQAListType_All;
                                                              [self updateData];
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"My Questions(%@)",@([[[MobileRTC sharedRTC] getMeetingService] getMyQuestionCount])]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.type = ZoomSampleQAListType_My;
                                                              [self updateData];
                                                          }]];
    } else {
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Open Questions(%@)",@([[[MobileRTC sharedRTC] getMeetingService] getOpenQuestionCount])]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.type = ZoomSampleQAListType_Open;
                                                              [self updateData];
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Answered Questions(%@)",@([[[MobileRTC sharedRTC] getMeetingService] getAnsweredQuestionCount])]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.type = ZoomSampleQAListType_Answered;
                                                              [self updateData];
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Dismissed Questions(%@)",@([[[MobileRTC sharedRTC] getMeetingService] getDismissedQuestionCount])]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.type = ZoomSampleQAListType_Dismissed;
                                                              [self updateData];
                                                          }]];
    }
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    if (IS_IPAD) {
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = self.navigationController.view;
            popover.sourceRect = CGRectMake(SCREEN_WIDTH,64,1.0,1.0);;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
   
    if (alertController.actions.count > 1) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MobileRTCQAItem * item = [_tableDataSource objectAtIndex:indexPath.row];

    NSString *answerSting = @"";
    NSArray *answerList = [item getAnswerlist];
    for (NSInteger i = 0; i < answerList.count; i ++)
    {
        MobileRTCQAAnswerItem *answeritem = [answerList objectAtIndex:i];
        if (i > 0 && i < answerList.count)
            answerSting = [answerSting stringByAppendingString:@", "];
        answerSting = [answerSting stringByAppendingString:[answeritem getText]];
    }
    
    ((QAListTableViewCell *)cell).contentLabel.text = [NSString stringWithFormat:@"QuestionId:%@  \nText:%@ \nTime:%@  \nSenderName:%@  \nisAnonymous:%@  \nisMarkedAsAnswered:%@  \nisMarkedAsDismissed:%@ \ngetUpvoteNumber:%@  \ngetHasLiveAnswers:%@ \ngetHasTextAnswers:%@ \nisMySelfUpvoted:%@ \namILiveAnswering:%@ \nisLiveAnswering:%@ \ngetLiveAnswerName:%@ \nAnswer:%@",[item getQuestionId],[item getText], [item getTime], [item getSenderName], @([item isAnonymous]), @([item isMarkedAsAnswered]), @([item isMarkedAsDismissed]), @([item getUpvoteNumber]), @([item getHasLiveAnswers]), @([item getHasTextAnswers]), @([item isMySelfUpvoted]), @([item amILiveAnswering]), @([item isLiveAnswering]), [item getLiveAnswerName], answerSting];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MobileRTCQAItem *questionItem = [_tableDataSource objectAtIndex:indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    if ([[[MobileRTC sharedRTC] getMeetingService] isMeetingHost]
        || [[[MobileRTC sharedRTC] getMeetingService] isMeetingCoHost]
        || [[[MobileRTC sharedRTC] getMeetingService] isWebinarPanelist]
        ) {
        
        if (!questionItem.isMarkedAsDismissed) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Add Answer"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] answerQuestionPublic:[questionItem getQuestionId] answerContent:@"QA-Answer-Question-Test"];
                                                                  NSLog(@"Answer Question ===> %@",@(ret));
                                                              }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss Question"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] dismissQuestion:[questionItem getQuestionId]];
                                                                  NSLog(@"Dismiss Question ===> %@",@(ret));
                                                              }]];
        }
        
        
        if (questionItem.isMarkedAsDismissed) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Reopen Question"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] reopenQuestion:[questionItem getQuestionId]];
                                                                  NSLog(@"Reopen Question ===> %@",@(ret));
                                                              }]];
        }
        
        if (!questionItem.amILiveAnswering && ![questionItem isMarkedAsDismissed] && ![questionItem isMarkedAsAnswered]) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Start Living"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] startLiving:[questionItem getQuestionId]];
                                                                  NSLog(@"Start Living ===> %@",@(ret));
                                                              }]];
        }
        
        if (questionItem.amILiveAnswering  && ![questionItem isMarkedAsDismissed] && ![questionItem isMarkedAsAnswered]) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"End Living"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] endLiving:[questionItem getQuestionId]];
                                                                  NSLog(@"End Living ===> %@",@(ret));
                                                              }]];
        }
        
        
    } else { // attendee
        if ([[[MobileRTC sharedRTC] getMeetingService] isAllowCommentQuestion] && ![questionItem isMarkedAsDismissed]) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Attendee Comment Answer"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] commentQuestion:[questionItem getQuestionId] commentContent:@"QA-Attendee-comment-Question-Test"];
                                                                  NSLog(@"Comment ===> %@",@(ret));
                                                              }]];
        }
    }
    
    if ([[[MobileRTC sharedRTC] getMeetingService] isAllowAttendeeUpVoteQuestion] && ![questionItem isMarkedAsDismissed]) {
        if (!questionItem.isMySelfUpvoted) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Vote Up"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] voteupQuestion:[questionItem getQuestionId] voteup:YES];
                                                                  NSLog(@"Vote Up ===> %@",@(ret));
                                                              }]];
        } else {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Unvote Up"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  BOOL ret = [[[MobileRTC sharedRTC] getMeetingService] voteupQuestion:[questionItem getQuestionId] voteup:NO];
                                                                  NSLog(@"Unvote Up ===> %@",@(ret));
                                                              }]];
        }
        
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    if (IS_IPAD) {
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = cell;
            popover.sourceRect = cell.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
    
    if (alertController.actions.count > 1) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[appDelegate topViewController] presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)updateData {
    switch (self.type) {
        case ZoomSampleQAListType_All:
            self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getAllQuestionList];
            break;
        case ZoomSampleQAListType_My:
            self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getMyQuestionList];
            break;
        case ZoomSampleQAListType_Open:
            self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getOpenQuestionList];
            break;
        case ZoomSampleQAListType_Answered:
            self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getAnsweredQuestionList];
            break;
        case ZoomSampleQAListType_Dismissed:
            self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getDismissedQuestionList];
            break;
        default:
            self.tableDataSource = [[[MobileRTC sharedRTC] getMeetingService] getAllQuestionList];
            break;
    }
    [self.tableView reloadData];
}

- (void)onSinkQAAddQuestion:(NSString *_Nonnull)questionID success:(BOOL)success
{
    NSLog(@"Webinar Q&A--onSinkQAAddQuestion success=%@ questionID=%@", @(success), questionID);
    [self updateData];
}

- (void)onSinkQAAddAnswer:(NSString *_Nonnull)answerID success:(BOOL)success
{
    NSLog(@"Webinar Q&A--onSinkQAAddAnswer success=%@ answerID=%@", @(success), answerID);
    [self updateData];
}

- (void)onSinkQuestionMarkedAsDismissed:(NSString *_Nonnull)questionID
{
    NSLog(@"Webinar Q&A--onSinkQuestionMarkedAsDismissed questionID=%@", questionID);
    [self updateData];
}

- (void)onSinkReopenQuestion:(NSString *_Nonnull)questionID
{
    NSLog(@"Webinar Q&A--onSinkReopenQuestion questionID=%@", questionID);
    [self updateData];
}

- (void)onSinkReceiveQuestion:(NSString *_Nonnull)questionID
{
    NSLog(@"Webinar Q&A--onSinkReceiveQuestion questionID=%@", questionID);
    [self updateData];
}

- (void)onSinkReceiveAnswer:(NSString *_Nonnull)answerID
{
    NSLog(@"Webinar Q&A--onSinkReceiveAnswer answerID=%@", answerID);
    [self updateData];
}

- (void)onSinkQuestionMarkedAsAnswered:(NSString *_Nonnull)questionID
{
    NSLog(@"Webinar Q&A--onSinkQuestionMarkedAsAnswered questionID=%@", questionID);
    [self updateData];
}

- (void)onSinkUserLivingReply:(NSString *_Nonnull)questionID
{
    NSLog(@"Webinar Q&A--onSinkUserLivingReply questionID=%@", questionID);
    [self updateData];
}

- (void)onSinkUserEndLiving:(NSString *_Nonnull)questionID
{
    NSLog(@"Webinar Q&A--onSinkUserEndLiving questionID=%@", questionID);
    [self updateData];
}

- (void)onSinkVoteupQuestion:(NSString *_Nonnull)questionID orderChanged:(BOOL)orderChanged
{
    NSLog(@"Webinar Q&A--onSinkUpvoteQuestion questionID=%@ orderChanged=%@", questionID, @(orderChanged));
    [self updateData];
}

- (void)onSinkRevokeVoteupQuestion:(NSString *_Nonnull)questionID orderChanged:(BOOL)orderChanged
{
    NSLog(@"Webinar Q&A--onSinkRevokeUpvoteQuestion questionID=%@ orderChanged=%@", questionID, @(orderChanged));
    [self updateData];
}

- (void)OnRefreshQAData
{
    [self updateData];
}

- (void)onMeetingStateChange:(MobileRTCMeetingState)state
{
    if(state == MobileRTCMeetingState_WebinarPromote || state == MobileRTCMeetingState_WebinarDePromote)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

