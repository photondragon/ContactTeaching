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

- (void)setScale:(CGFloat)scale
{
	_scale = scale;
	[self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	CGSize framesize = self.frame.size;

	CGFloat length = framesize.width<framesize.height? framesize.width : framesize.height;
	CGPoint topleft = CGPointMake((framesize.width-length)/2.0, (framesize.height-length)/2.0);

	UIBezierPath* path = [UIBezierPath bezierPath];

	//添加裁剪区域
	[path addArcWithCenter:CGPointMake(framesize.width/2.0, framesize.height/2.0) radius:length/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
	[path addClip];//添加裁剪区域不会删除之前的添加的Path

	[path removeAllPoints];

	//画矩形
	[path addRect:CGRectMake(topleft.x, topleft.y, length, length)];
	[[UIColor lightGrayColor] setFill];
	[path fill];

	[path removeAllPoints];

	//画圆
	[path addArcWithCenter:CGPointMake(framesize.width/2.0, topleft.y+length*0.42) radius:length/5.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
	[path addArcWithCenter:CGPointMake(framesize.width/2.0, topleft.y+length) radius:length/2.5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
	[[UIColor grayColor] setFill];
	[path fill];

	[path removeAllPoints];

	//画线
	[path moveToPoint:CGPointMake(0, 0)];
	[path addLineToPoint:CGPointMake(framesize.width, framesize.height)];
	[[UIColor redColor] setStroke];
	path.lineWidth = 1.0/[UIScreen mainScreen].scale;//设置线宽为1像素
	[path stroke];
}

@end
