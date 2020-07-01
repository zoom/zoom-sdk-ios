//
//  AudioRawDataHelper.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2019/8/7.
//  Copyright © 2019 Zoom Video Communications, Inc. All rights reserved.
//

#import "AudioRawDataSaveSandboxHelper.h"
#import <pthread.h>

@interface AudioRawDataSaveSandboxHelper ()

@end

@implementation AudioRawDataSaveSandboxHelper

- (void)saveAudioRawdata:(MobileRTCAudioRawData *)rawData {
    __uint64_t threadId=0;
    if (pthread_threadid_np(0, &threadId)) {
        threadId = pthread_mach_thread_np(pthread_self());
    }
    NSLog(@"%ld:%llu",(long)getpid(),threadId);
    
    NSString *path = [NSString stringWithFormat:@"%@", self.filePath];
    BOOL createSuccess = [self creatFile:path];
    if (createSuccess) {
        NSData *data = [NSData dataWithBytes:rawData.buffer length:rawData.bufferLen];
        [self appendData:data withPath:path];
    }
}

- (BOOL)creatFile:(NSString*)filePath{
    if (filePath.length==0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    NSError *error;
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    BOOL isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
//    if (error) {
//        NSLog(@"creat File Failed:%@",[error localizedDescription]);
//    }
    if (!isSuccess) {
        return isSuccess;
    }
    isSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return isSuccess;
}

- (BOOL)appendData:(NSData*)data withPath:(NSString *)filePath{
    if (filePath.length==0) {
        return NO;
    }
    BOOL result = [self creatFile:filePath];
    if (result) {
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [handle seekToEndOfFile];
        [handle writeData:data];
        [handle synchronizeFile];
        [handle closeFile];
    }
    else{
        NSLog(@"appendData Failed");
    }
    return result;
}


@end
