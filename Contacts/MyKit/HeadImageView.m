//
//  HeadImageView.m
//  Contacts
//
//  Created by photondragon on 15/5/9.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "HeadImageView.h"
#import "UIBezierPath+IDNExtend.h"

@implementation HeadImageView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	CGSize framesize = self.frame.size;
	CGFloat width = framesize.width<framesize.height? framesize.width : framesize.height;

	UIBezierPath* path = [UIBezierPath bezierPath];
	[path addRect:CGRectMake((framesize.width-width)/2.0, (framesize.height-width)/2.0, width, width)];
	[[UIColor lightGrayColor] setFill];
	[path fill];
	[path removeAllPoints];

	[path addArcWithCenter:CGPointMake(framesize.width/2.0, framesize.height*0.42) radius:width/5.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
	[path addArcWithCenter:CGPointMake(framesize.width/2.0, framesize.height) radius:width/2.5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
	[[UIColor grayColor] setFill];
	[path fill];
}

@end
