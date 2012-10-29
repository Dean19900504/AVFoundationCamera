//
//  AVFoundationCameraAppDelegate.h
//  AVFoundationCamera
//
//  Created by huangjy on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVFoundationCameraViewController;

@interface AVFoundationCameraAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AVFoundationCameraViewController *controller;

@end
