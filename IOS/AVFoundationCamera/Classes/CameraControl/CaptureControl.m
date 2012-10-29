//
//  CaptureControl.m
//  Test
//
//  Created by sunshowmini on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CaptureControl.h"

@interface CaptureControl()

@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureDeviceInput *captureInput;
@property (retain) AVCaptureStillImageOutput *captureOutput;
@property (retain) AVCaptureDevice *captureDevice;
@property (retain) AVCaptureConnection *captureConnection;
@property (assign) CFRunLoopSourceRef source;

@end

@implementation CaptureControl

@synthesize captureSession = _captureSession;
@synthesize captureInput = _captureInput;
@synthesize captureOutput = _captureOutput;
@synthesize captureDevice = _captureDevice;
@synthesize captureConnection = _captureConnection;
@synthesize delegate = _delegate;

@synthesize captureData = _captureData;
@synthesize captureError = _captureError;

@synthesize tag = _tag;
@synthesize captureFinishedSelector = _captureFinishedSelector;
@synthesize captureFailedSelector = _captureFailedSelector;
@synthesize source = _source;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.captureSession = [[[AVCaptureSession alloc] init] autorelease];
        self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    }
    return self;
}

- (void)main
{
    @autoreleasepool {
        NSLog(@"operation start");
        [self startCapture];
        
        CFRunLoopSourceContext source_context;
        bzero(&source_context, sizeof(source_context));
        source_context.perform = capture_cleanup;
        source_context.info = self;
        _source = CFRunLoopSourceCreate(NULL, 0, &source_context);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), _source, kCFRunLoopCommonModes);
        CFRunLoopRun();
        [self retain];
        
    }
}

+ (CaptureControl *)captureControlWithDevice:(AVCaptureDevice *)device
{
    CaptureControl *captureControl = [[[self alloc] init] autorelease];
    [captureControl setCaptureDevice:device];
    return captureControl;
}

static void capture_cleanup(void *info)
{
    CaptureControl *captureControl = (CaptureControl *)info;
    [captureControl release];
    
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)setCaptureDevice:(AVCaptureDevice *)captureDevice
{
    [_captureDevice release];
    _captureDevice = [captureDevice retain];
    
    self.captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    
    if([self.captureSession canAddInput:self.captureInput])
        [self.captureSession addInput:self.captureInput];
    
    self.captureOutput = [[[AVCaptureStillImageOutput alloc] init] autorelease];
    [self.captureOutput setOutputSettings:[NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil]];
    if([self.captureSession canAddOutput:self.captureOutput])
        [self.captureSession addOutput:self.captureOutput];
    
    [self startRunning];
    
    AVCaptureConnection  *videoConnection = nil;     
    for (AVCaptureConnection *connection in self.captureOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    self.captureConnection = videoConnection;
    
    
//    dispatch_queue_t queue = dispatch_queue_create("augm_reality", NULL);
//    dispatch_set_context(queue, self);
//    dispatch_set_finalizer_f(queue, capture_cleanup);
//    dispatch_release(queue);
//    [self retain];
    
}

//开启capture session
- (void)startRunning
{
    [self.captureSession startRunning];
}

//开始拍照
- (void)startCapture
{
    [self.captureOutput captureStillImageAsynchronouslyFromConnection:self.captureConnection
                                                                completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
    {
        if(error == nil)
        {
            self.captureError = nil;
            self.captureData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            if(self.delegate && [self.delegate respondsToSelector:self.captureFinishedSelector])
                [self.delegate performSelector:self.captureFinishedSelector withObject:self];
        }
        else {
            self.captureError = error;
            self.captureData = nil;
            if(self.delegate && [self.delegate respondsToSelector:self.captureFailedSelector])
                [self.delegate performSelector:self.captureFailedSelector withObject:self];
        }
        CFRunLoopSourceSignal(_source);
    }];
}

- (AVCaptureDevice *)captureDevice
{
    return _captureDevice;
}

- (void)dealloc
{
    [_captureSession stopRunning];
    [_captureInput release];
    [_captureOutput release];
    [_captureDevice release];
    [_captureConnection release];
    [_captureData release];
    [_captureError release];
    [_captureSession release];
    [super dealloc];
}

@end
