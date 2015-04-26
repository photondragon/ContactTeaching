//
//  ImageViewController.m
//  Contacts
//
//  Created by photondragon on 15/4/19.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
<UIScrollViewDelegate>
{
	UIScrollView* scrollView;
	UIImageView* imageView;
}

@end

@implementation ImageViewController

- (void)loadView
{
	imageView = [[UIImageView alloc] init];
	imageView.backgroundColor = [UIColor darkGrayColor];

	scrollView = [[UIScrollView alloc] init];
	scrollView.backgroundColor = [UIColor grayColor];
	scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	scrollView.delegate = self;
	[scrollView addSubview:imageView];

	UIView* view = [[UIView alloc] init];
	view.backgroundColor = [UIColor blueColor];
	[view addSubview:scrollView];

	self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.edgesForExtendedLayout = 0;
	self.title = @"查看图片";
}

- (void)setImagePath:(NSString *)imagePath
{
	_imagePath = imagePath;

	[self view];

	UIImage* image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	imageView.image = image;

	CGSize imagesize = image.size;
	imageView.frame = CGRectMake(0, 0, imagesize.width, imagesize.height);

	scrollView.contentSize = imagesize;

	[self recalcDisplayInfo];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[self recalcDisplayInfo];
}

- (void)recalcDisplayInfo
{
	CGSize containerSize = scrollView.frame.size;
	CGSize imagesize = imageView.image.size;

	if (containerSize.width<=0 || containerSize.height<=0 ||
		imagesize.width <=0 || imagesize.height<=0) {
		scrollView.minimumZoomScale = 1;
		scrollView.maximumZoomScale = 1;
	}
	else
	{
		CGFloat hRatio = containerSize.width/imagesize.width;
		CGFloat vRatio = containerSize.height/imagesize.height;

		CGFloat minRation = hRatio < vRatio ? hRatio : vRatio;
		CGFloat maxRation = hRatio > vRatio ? hRatio : vRatio;

		CGFloat minScale = minRation;
		CGFloat maxScale = maxRation;

		if (minScale>1.0)
			minScale = 1;
		if (maxScale<1)
			maxScale = 1;

		scrollView.minimumZoomScale = minScale;
		scrollView.maximumZoomScale = maxScale;

		CGFloat scale = scrollView.zoomScale;
		if(scale<minScale)
			scale = minScale;
		else if(scale>maxScale)
			scale = maxScale;
		scrollView.zoomScale = scale;
		
		[self centerContentView];
	}
}

- (void)centerContentView
{
	CGSize containerSize = scrollView.frame.size;
	CGSize imagesize = imageView.image.size;
	CGFloat scale = scrollView.zoomScale;
	CGSize imageViewSize;
	imageViewSize.width = imagesize.width*scale;
	imageViewSize.height = imagesize.height*scale;

	CGPoint padding;
	if(imageViewSize.width < containerSize.width)
		padding.x = (containerSize.width-imageViewSize.width)/2;
	else
		padding.x = 0;

	if(imageViewSize.height < containerSize.height)
		padding.y = (containerSize.height-imageViewSize.height)/2;
	else
		padding.y = 0;

	imageView.center = CGPointMake(padding.x+imageViewSize.width/2, padding.y+imageViewSize.height/2);
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return imageView;
}

//每当zoomScale改变时，会被调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	[self centerContentView];
}

@end
