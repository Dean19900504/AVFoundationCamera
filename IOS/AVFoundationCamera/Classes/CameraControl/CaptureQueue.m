//
//  CaptureQueue.m
//  Test
//
//  Created by sunshowmini on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CaptureQueue.h"

@interface CaptureQueue()

@property (retain) NSMutableDictionary *captureDevices;

@end

@implementation CaptureQueue

@synthesize operationQueue = _operationQueue;
@synthesize captureDevices = _captureDevices;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.captureDevices = [NSMutableDictionary dictionaryWithCapacity:1];
        self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
//        [self.operationQueue setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (void)dealloc
{
    [self.operationQueue cancelAllOperations];
    [_operationQueue release];
    [_captureDevices release];
    [super dealloc];
}


- (void)addCaptureDevice:(AVCaptureDevice *)captureDevice withDeviceName:(NSString *)deviceName
{
    [self.captureDevices setValue:captureDevice forKey:deviceName];
}

- (AVCaptureDevice *)captureDeviceWithName:(NSString *)deviceName
{
    return (AVCaptureDevice *)[self.captureDevices objectForKey:deviceName];
}

- (void)addCaptureControl:(CaptureControl *)captureControl
{
    [self.operationQueue addOperation:captureControl];
    [self.operationQueue setSuspended:YES];
}


- (void)go
{
    [self.operationQueue setSuspended:NO];
}

- (void)cancelCaptureControl:(CaptureControl *)captureControl
{
    [captureControl cancel];
}

- (void)cancelAllCaptureControl
{
    [self.operationQueue cancelAllOperations];
}

@end
