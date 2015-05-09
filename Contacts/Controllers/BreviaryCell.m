//
//  BreviaryCell.m
//  Contacts
//
//  Created by photondragon on 15/5/9.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "BreviaryCell.h"
#import "MyCommon.h"
#import "UIImage+IDNExtend.h"

@interface BreviaryCell()
{
	NSString* currentImageFile;//当前要加载的图像文件的全路径
	UIImageView* imageView;
}

@end

@implementation BreviaryCell

- (void)initializer
{
	if(imageView)
		return;
	imageView = [[UIImageView alloc] initWithFrame:self.bounds];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	imageView.clipsToBounds = YES;
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.contentView addSubview:imageView];
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self initializer];
	}
	return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initializer];
	}
	return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initializer];
	}
	return self;
}

- (void)setImagePath:(NSString*)imgfile
{
	[self setImagePath:imgfile placeHolder:nil];
}

- (void)setImagePath:(NSString*)imgfile placeHolder:(UIImage*)placeHolder
{//在主线程运行
	if(imgfile && imgfile.length==0)//如果是空串""
		imgfile = nil;
	@synchronized(self)
	{
		currentImageFile = imgfile;
	}
	imageView.image = placeHolder;
	if(imgfile==nil)
		return;
	NSOperation* operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadImage:) object:imgfile];
	[[MyCommon AppQueue] addOperation:operation];
}

//后台加载指定图像。此方法在后台线程运行
- (void)loadImage:(NSString*)imgfile
{
	NSString* current;
	@synchronized(self)
	{
		current = currentImageFile;
	}

	if([current isEqualToString:imgfile]==false)//当前图像已经改变，所以不用加载原来的文件
		return;
	UIImage* img = [UIImage imageWithContentsOfFile:imgfile];//从磁盘读取图像
	img = [img resizedImageWithAspectFitSize:CGSizeMake(256, 256)];//强制图像解码（原始大小）

	@synchronized(self)
	{
		current = currentImageFile;
	}

	if([current isEqualToString:imgfile]==false)//当前图像已经改变，所以不用加载原来的文件
		return;

	//利用GCD，将@selector(imageLoaded:forFile:)方法提交到主线程去执行
	dispatch_async(dispatch_get_main_queue(), ^{
		[self imageLoaded:img forFile:imgfile];
	});
}

//将加载好的图像显示到imageView中
- (void)imageLoaded:(UIImage*)img forFile:(NSString*)imgfile
{//在主线程运行
//	@synchronized(self)
//	{
	if([currentImageFile isEqualToString:imgfile]==false)//当前图像已经改变，之前加载的图像无效
		return;
//	}

	imageView.image = img;
}

@end
