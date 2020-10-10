//
//  ControlBar.h
//
//  Created by Zoom Video Communications on 2019/5/27.
//  Copyright © 2019 Zoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraCaptureAdapter.h"
#import "SendPictureAdapter.h"
#import "SendYUVAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface ControlBar : UIView
- (void)updateMyAudioStatus;
- (void)updateMyVideoStatus;

@property (nonatomic,strong) CameraCaptureAdapter *cameraAdapter;
@property (nonatomic,strong) SendPictureAdapter *picAdapter;
@property (nonatomic,strong) SendYUVAdapter     *yuvAdapter;


@end

NS_ASSUME_NONNULL_END
