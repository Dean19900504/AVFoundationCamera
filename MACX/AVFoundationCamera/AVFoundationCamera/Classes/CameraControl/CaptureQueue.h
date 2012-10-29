//
//  CaptureQueue.h
//  Test
//
//  Created by sunshowmini on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaptureControl.h"

@interface CaptureQueue : NSObject

@property (nonatomic,retain) NSOperationQueue *operationQueue;

- (void)addCaptureControl:(CaptureControl *)captureControl;

- (void)go;

- (void)cancelCaptureControl:(CaptureControl *)captureControl;

- (void)cancelAllCaptureControl;

@end
