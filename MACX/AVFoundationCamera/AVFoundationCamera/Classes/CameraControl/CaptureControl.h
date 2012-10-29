//
//  CaptureControl.h
//  Test
//
//  Created by sunshowmini on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CaptureControl : NSOperation

@property (assign) id delegate;

@property (retain) NSData *captureData;
@property (retain) NSError *captureError;

@property (assign) UInt32 tag;
@property (assign) SEL captureFinishedSelector;
@property (assign) SEL captureFailedSelector;

//创建Capture控制器
+ (CaptureControl *)captureControlWithDevice:(AVCaptureDevice *)device;

//设置Capture设备
- (void)setCaptureDevice:(AVCaptureDevice *)captureDevice;
@end
