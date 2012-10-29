//
//  AVFoundationCameraAppDelegate.m
//  AVFoundationCamera
//
//  Created by huangjy on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AVFoundationCameraAppDelegate.h"

@implementation AVFoundationCameraAppDelegate

@synthesize window = _window;
@synthesize imageCell = _imageCell;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSArray *devices = [AVCaptureDevice devices];
    for(AVCaptureDevice *device in devices)
    {
        NSLog(@"UniqueID:%@", device.uniqueID);
    }
}

- (void)button1Clicked:(id)sender
{
    AVCaptureDevice *captureDevice = [AVCaptureDevice deviceWithUniqueID:@"0xfa20000005ac8509"];
    CaptureControl *captureControl = [CaptureControl captureControlWithDevice:captureDevice];
    captureControl.delegate = self;
    captureControl.captureFinishedSelector = @selector(captureFinished:);
    captureControl.captureFailedSelector = @selector(captureFailed:);
    [[CaptureHandler shareHander] addCaptureControlAndGo:captureControl];
    
}

- (void)button2Clicked:(id)sender
{
    AVCaptureDevice *captureDevice = [AVCaptureDevice deviceWithUniqueID:@"0xfa20000005ac8509"];
    CaptureControl *captureControl = [CaptureControl captureControlWithDevice:captureDevice];
    captureControl.delegate = self;
    captureControl.captureFinishedSelector = @selector(captureFinished:);
    captureControl.captureFailedSelector = @selector(captureFailed:);
    [[CaptureHandler shareHander] addCaptureControlAndGo:captureControl];
}


- (void)captureFinished:(CaptureControl *)captureControl
{
    self.imageCell.image = [[[NSImage alloc] initWithData:captureControl.captureData] autorelease];
}

- (void)captureFailed:(CaptureControl *)captureControl
{
    NSLog(@"capture failed:%@",[captureControl.captureError description]);
}
@end
