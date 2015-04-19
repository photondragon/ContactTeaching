//
//  MyModels.m
//  Contacts
//
//  Created by photondragon on 15/4/12.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "MyModels.h"
#import "NSString+IDNExtend.h"

@implementation MyModels

+ (ContactManage*)contactManager
{
	static ContactManage* contackManager = nil; //这句赋值代码只运行一次
	if(contackManager==nil)
	{
		contackManager = (ContactManage*)[NSKeyedUnarchiver unarchiveObjectWithFile:[NSString documentsPathWithFileName:@"contacts.dat"]];
		if(contackManager==nil)
			contackManager = [[ContactManage alloc] init];
	}
	return contackManager;
}

+ (void)save
{
	[NSKeyedArchiver archiveRootObject:[self contactManager] toFile:[NSString documentsPathWithFileName:@"contacts.dat"]];
}

@end
