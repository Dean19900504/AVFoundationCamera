//
//  AVFoundationCameraAppDelegate.h
//  AVFoundationCamera
//
//  Created by huangjy on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CaptureHandler.h"

@interface AVFoundationCameraAppDelegate : NSObject <NSApplicationDelegate>


@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSImageCell *imageCell;

- (IBAction)button1Clicked:(id)sender;

- (IBAction)button2Clicked:(id)sender;

@end
