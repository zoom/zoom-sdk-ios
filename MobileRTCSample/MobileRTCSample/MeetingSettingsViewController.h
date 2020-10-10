//
//  MeetingSettingsViewController.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2017/8/18.
//  Copyright © 2017年 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Custom_Meeting_Cell_Tag 10000
#define Raw_Data_Cell_Tag 10001
#define Raw_Data_UI_Enable @"raw.data.ui.enable"
#define Raw_Data_Send_Enable @"raw.data.send.enable"

@interface MeetingSettingsViewController : UITableViewController

-(void)enableSendRawdata:(BOOL)enable;

@end
