//
//  CaptureHandler.h
//  Test
//
//  Created by sunshowmini on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaptureQueue.h"

@interface CaptureHandler : NSObject

+ (CaptureHandler *)shareHander;

- (void)addCaptureControl:(id)captureControl;

- (void)addCaptureControlAndGo:(id)captureControl;

- (void)cancelAllCaptureControl;

@end
