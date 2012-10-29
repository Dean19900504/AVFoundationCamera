//
//  AVFoundationCameraViewController.m
//  AVFoundationCamera
//
//  Created by huangjy on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AVFoundationCameraViewController.h"

@interface AVFoundationCameraViewController ()

@end

@implementation AVFoundationCameraViewController

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    AVFoundationCameraView *view = [[AVFoundationCameraView alloc] initWithFrame:bounds];
    view.delegate = self;
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AVFoundationCameraView *view = (AVFoundationCameraView *)self.view;
    [view startUpdate:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    AVFoundationCameraView *view = (AVFoundationCameraView *)self.view;
    [view stopUpdate:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
