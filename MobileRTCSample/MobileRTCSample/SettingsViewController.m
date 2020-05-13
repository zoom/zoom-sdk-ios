//
//  SettingsViewController.m
//  MobileRTCSample
//
//  Created by Robust Hu on 7/6/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import "SettingsViewController.h"
#import "LanguaguePickerViewController.h"
#import "MeetingSettingsViewController.h"
#import "ScheduleTableViewController.h"
#import <MobileRTC/MobileRTC.h>
#import "SDKAuthPresenter.h"
#import <MessageUI/MessageUI.h>

@interface SettingsViewController () <MFMailComposeViewControllerDelegate>

@property (retain, nonatomic) UITableViewCell *meetingCell;
@property (retain, nonatomic) UITableViewCell *languageCell;
@property (retain, nonatomic) UITableViewCell *loginCell;
@property (retain, nonatomic) UITableViewCell *scheduleCell;
@property (retain, nonatomic) UITableViewCell *swtichDomainCell;

@property (retain, nonatomic) NSArray *itemArray;

@property (retain, nonatomic) SDKAuthPresenter      *authPresenter;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Settings", @"");
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    [closeItem release];
    
    [self initSettingItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)initSettingItems
{
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:@[[self meetingCell]]];
    
    [array addObject:@[[self languageCell]]];
    
    if ([[[MobileRTC sharedRTC] getAuthService] isLoggedIn])
    {
        [array addObject:@[[self scheduleCell]]];
    }
    
    [array addObject:@[[self swtichDomainCell]]];
    
    [array addObject:@[[self loginCell]]];
    
    self.itemArray = array;
    
    [self.tableView reloadData];
}

#pragma mark - Table Cell

- (UITableViewCell*)meetingCell
{
    if (!_meetingCell)
    {
        _meetingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _meetingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _meetingCell.textLabel.text = NSLocalizedString(@"Meeting Settings", @"");
        _meetingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _meetingCell;
}

- (UITableViewCell*)languageCell
{
    if (!_languageCell)
    {
        _languageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _languageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _languageCell.textLabel.text = NSLocalizedString(@"Select Language", @"");
        _languageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _languageCell;
}

- (UITableViewCell *)swtichDomainCell {
    if (!_swtichDomainCell)
    {
        _swtichDomainCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _swtichDomainCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _swtichDomainCell.textLabel.text = NSLocalizedString(@"Switch Domain and Auth Again", @"");
        _swtichDomainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _swtichDomainCell;
}

- (UITableViewCell*)loginCell
{
    if (!_loginCell)
    {
        _loginCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _loginCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _loginCell.textLabel.text = NSLocalizedString(@"Sign In", @"");
        _loginCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BOOL isLoggedIn = [[[MobileRTC sharedRTC] getAuthService] isLoggedIn];
    NSString *title = isLoggedIn ? NSLocalizedString(@"Sign Out", @"") : NSLocalizedString(@"Sign In", @"");
    UIColor *titleColor = isLoggedIn ? [UIColor redColor] : [UIColor blueColor];
    _loginCell.textLabel.text = title;
    _loginCell.textLabel.textColor = titleColor;
    
    return _loginCell;
}

- (UITableViewCell*)scheduleCell
{
    if (!_scheduleCell)
    {
        _scheduleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _scheduleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _scheduleCell.textLabel.text = NSLocalizedString(@"Schedule Meeting", @"");
        _scheduleCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _scheduleCell;
}

- (SDKAuthPresenter *)authPresenter
{
    if (!_authPresenter)
    {
        _authPresenter = [[SDKAuthPresenter alloc] init];
    }
    
    return _authPresenter;
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
    if ([cell isEqual:_languageCell])
    {
        LanguaguePickerViewController * vc = [[LanguaguePickerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        return;
    }
    
    if ([cell isEqual:_meetingCell])
    {
        MeetingSettingsViewController * vc = [[MeetingSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        return;
    }
    
    if ([cell isEqual:_swtichDomainCell]) {
        [self switchDomainAndAuthAgain];
        return;
    }

    if ([cell isEqual:_loginCell])
    {
        if ([[[MobileRTC sharedRTC] getAuthService] isLoggedIn])
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [[[MobileRTC sharedRTC] getAuthService] logoutRTC];
            }];
        }
        else
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Select Login Type", @"")
                                                                                         message:nil
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Login with Email", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self loginWithEmail];
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Login with SSO", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self loginWithSSO];
                }]];
                
                [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        return;
    }
    
    if ([cell isEqual:_scheduleCell])
    {
        ScheduleTableViewController *vc = [[ScheduleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        return;
    }
}

- (void)switchDomainAndAuthAgain {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Switch domain and auth again", @"")
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = NSLocalizedString(@"New Domain", @"");
            textField.text = @"";
        }];
        
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UITextField *newDomain = alertController.textFields.firstObject;
          
            BOOL ret = [[MobileRTC sharedRTC] switchDomain:newDomain.text force:YES];
            NSLog(@"switchDomain-ret ===> %d", ret);
            
            [[[SDKAuthPresenter alloc] init] SDKAuth:@"New SDK Key" clientSecret:@"New SDK Secret"];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVC presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)loginWithEmail
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Login with Email", @"")
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = NSLocalizedString(@"Work Email", @"");
                textField.keyboardType = UIKeyboardTypeEmailAddress;
                textField.text = @"";
            }];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = NSLocalizedString(@"Password", @"");
                textField.secureTextEntry = YES;
                textField.text = @"";
            }];
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UITextField *email = alertController.textFields.firstObject;
                UITextField *password = alertController.textFields.lastObject;
                [self.authPresenter loginWithEmail:email.text password:password.text rememberMe:YES];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            
            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            [rootVC presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (void)loginWithSSO
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Login with SSO", @"")
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = NSLocalizedString(@"SSO Token", @"");
            }];
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UITextField *token = alertController.textFields.firstObject;
                [self.authPresenter loginWithSSOToken:token.text rememberMe:YES];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            
            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            [rootVC presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

@end
