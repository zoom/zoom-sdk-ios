//
//  LanguaguePickerViewController.m
//  MobileRTCSample
//
//  Created by chaobai on 16/8/23.
//  Copyright © 2016年 Zoom Video Communications, Inc. All rights reserved.
//

#import "LanguaguePickerViewController.h"
#import <MobileRTC/MobileRTC.h>

@interface LanguaguePickerViewController ()

@property (nonatomic, retain) NSArray * languageArray;

@end

@implementation LanguaguePickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Select Language", @"");
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector( onDone: )];

    self.languageArray = [[MobileRTC sharedRTC] supportedLanguages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return( 1 );
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return( _languageArray.count );
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusedId = @"lang";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if( cell == nil )
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    
    cell.textLabel.text = _languageArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return( cell );
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[MobileRTC sharedRTC] setLanguage:_languageArray[indexPath.row]];
    [self onDone:nil];
}

- (void)onDone:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
