//
//  ImageViewController.m
//  Contacts
//
//  Created by photondragon on 15/4/19.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)loadView
{
	self.view = [[MyImageViewer alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	UITapGestureRecognizer* tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwice:)];
	tapTwice.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:tapTwice];

	UITapGestureRecognizer* tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce:)];
	[tapOnce requireGestureRecognizerToFail:tapTwice];
	[self.view addGestureRecognizer:tapOnce];
}

- (void)tapOnce:(UITapGestureRecognizer*)gesture
{
	BOOL hidden = !self.navigationController.navigationBarHidden;
	[self.navigationController setNavigationBarHidden:hidden animated:YES];
//	[[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationFade];
}

- (void)tapTwice:(UITapGestureRecognizer*)gesture
{
	if(self.imageViewer.maximized==NO)
		[self.imageViewer setZoomScale:999999 animated:YES];
	else
		[self.imageViewer setZoomScale:0 animated:YES];
}

- (MyImageViewer*)imageViewer
{
	return (MyImageViewer*)self.view;
}

@end
