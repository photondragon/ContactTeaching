//
//  ImageViewController.m
//  Contacts
//
//  Created by photondragon on 15/4/19.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property(nonatomic,strong) UIImageView* imageView;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.edgesForExtendedLayout = 0;
	self.title = @"查看图片";

	CGSize framesize = self.view.frame.size;

	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, framesize.width-40, framesize.height-40)];
//	self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	self.imageView.backgroundColor = [UIColor darkGrayColor];
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImagePath:(NSString *)imagePath
{
	_imagePath = imagePath;

	[self view];

	if (imagePath.length)
		self.imageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	else
		self.imageView.image = nil;
}

@end
