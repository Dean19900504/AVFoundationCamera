//
//  CaptureHandler.m
//  Test
//
//  Created by sunshowmini on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CaptureHandler.h"

static CaptureHandler *_captureHandler = nil;

@interface CaptureHandler()

@property (retain) CaptureQueue *captureQueue;

@end

@implementation CaptureHandler

@synthesize captureQueue = _captureQueue;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.captureQueue = [[CaptureQueue alloc] init];
    }
    return self;
}

+ (CaptureHandler *)shareHander
{
    @synchronized(self)
    {
        if(_captureHandler == nil)
            _captureHandler = [[self alloc] init];
    }
    return _captureHandler;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(_captureHandler == nil)
            _captureHandler = [super allocWithZone:zone];
    }
    return _captureHandler;
}

- (void)addCaptureControl:(id)captureControl
{
    [self.captureQueue addCaptureControl:captureControl];
}

- (void)addCaptureControlAndGo:(id)captureControl
{
    [self.captureQueue addCaptureControl:captureControl];
    [self.captureQueue go];
}

- (void)cancelAllCaptureControl
{
    [self.captureQueue cancelAllCaptureControl];
}

- (void)dealloc
{
    [self.captureQueue cancelAllCaptureControl];
    [_captureQueue release];
    [super dealloc];
}

@end
