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

	self.edgesForExtendedLayout = 0;
	self.title = @"查看图片";
}

- (MyImageViewer*)imageViewer
{
	return (MyImageViewer*)self.view;
}

@end
