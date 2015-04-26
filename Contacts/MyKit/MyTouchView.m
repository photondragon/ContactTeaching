//
//  MyTouchView.m
//  Contacts
//
//  Created by photondragon on 15/4/26.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "MyTouchView.h"

@implementation MyTouchView
{
	BOOL moved;
	NSTimeInterval touchDownTime;
	CGPoint touchPoint;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	moved = NO;
	touchDownTime = [NSDate timeIntervalSinceReferenceDate];

	touchPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	moved = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint point = [[touches anyObject] locationInView:self];

	if(moved && ((point.x-touchPoint.x)*(point.x-touchPoint.x)
		 +((point.y-touchPoint.y)*(point.y-touchPoint.y))>5*5))
	{
		NSLog(@"不是单击");
	}
	else
	{
		NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
		if(now-touchDownTime < 0.5)
		{
			NSLog(@"单击");
		}
		else
			NSLog(@"不是单击");
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
