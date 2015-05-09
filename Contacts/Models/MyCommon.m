//
//  MyCommon.m
//  Contacts
//
//  Created by photondragon on 15/5/9.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "MyCommon.h"

@implementation MyCommon

+(NSOperationQueue*) AppQueue
{
	static NSOperationQueue* appQueue	= nil;
	if(appQueue==nil)
	{
		appQueue = [[NSOperationQueue alloc] init];
		[appQueue setMaxConcurrentOperationCount:2];
	}
	return appQueue;
}

@end
