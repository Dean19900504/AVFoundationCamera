//
//  AVFoundationCameraView.h
//  AVFoundationCamera
//
//  Created by huangjy on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol AVFoundationCameraEvent <NSObject>

@end

@interface AVFoundationCameraView : UIView

@property (nonatomic, assign) id<AVFoundationCameraEvent> delegate;

- (void)startUpdate:(id)userInfo;

- (void)stopUpdate:(id)userInfo;

@end
