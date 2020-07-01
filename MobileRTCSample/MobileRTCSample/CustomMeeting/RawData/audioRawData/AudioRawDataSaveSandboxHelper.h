//
//  AudioRawDataHelper.h
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2019/8/7.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioRawDataSaveSandboxHelper : NSObject

@property (nonatomic, copy) NSString *filePath;

- (void)saveAudioRawdata:(MobileRTCAudioRawData *)rawData;

@end
