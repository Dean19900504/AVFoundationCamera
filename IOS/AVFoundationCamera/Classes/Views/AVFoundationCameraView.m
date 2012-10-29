//
//  AVFoundationCameraView.m
//  AVFoundationCamera
//
//  Created by huangjy on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AVFoundationCameraView.h"
#import "CaptureHandler.h"

@interface AVFoundationCameraView()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIButton *captureButton;

@end

@implementation AVFoundationCameraView

@synthesize delegate = _delegate;
@synthesize imageView = _imageView;
@synthesize captureButton = _captureButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, 400)] autorelease];
        [self addSubview:self.imageView];
        
        self.captureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.captureButton.frame = CGRectMake(10, 420, frame.size.width - 20, 30);
        [self.captureButton setTitle:@"拍照" forState:UIControlStateNormal];
        [self.captureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.captureButton addTarget:self action:@selector(captureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.captureButton];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)startUpdate:(id)userInfo
{
    
}

- (void)stopUpdate:(id)userInfo
{
}

- (void)captureButtonClicked:(id)sender
{
    AVCaptureDevice *captureDevice = nil;
    NSArray *devices = [AVCaptureDevice devices];
    for (AVCaptureDevice *device in devices) 
    {
        if ([device hasMediaType:AVMediaTypeVideo]) 
        {
#if 0
            if ([device position] == AVCaptureDevicePositionBack) 
            {
                captureDevice = device;
                break;
                
            }
#else
            if ([device position] == AVCaptureDevicePositionFront) 
            {
                captureDevice = device;
                break;
            }
#endif
        }
    }
    if(captureDevice)
    {
        CaptureControl *captureControl = [CaptureControl captureControlWithDevice:captureDevice];
        captureControl.delegate = self;
        captureControl.captureFinishedSelector = @selector(captureFinished:);
        captureControl.captureFailedSelector = @selector(captureFailed:);
        [[CaptureHandler shareHander] addCaptureControlAndGo:captureControl];   
    }
}

- (void)captureFinished:(CaptureControl *)captureControl
{
    self.imageView.image = [[[UIImage alloc] initWithData:captureControl.captureData] autorelease];
}

- (void)captureFailed:(CaptureControl *)captureControl
{
    NSLog(@"capture failed:%@",[captureControl.captureError description]);
}

- (void)dealloc
{
    [_imageView release];
    [_captureButton release];
    [super dealloc];
}

@end
