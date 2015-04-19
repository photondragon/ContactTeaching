//
//  ContactManage.m
//  ContactManage
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactManage.h"
#import "NSString+IDNExtend.h"

@implementation ContactManage
{
	NSMutableArray* contacts;
}

- (instancetype)init
{
	self = [super init];
	if(self)
	{
		contacts = [[NSMutableArray alloc] init];
	}
	return self;
}

- (ContactInfo*)contactAtIndex:(NSUInteger)index
{
	return contacts[index];
}

- (NSUInteger)count{
	return contacts.count;
}

- (void)addContact:(ContactInfo*)contact
{
	[contacts addObject:contact];
}

- (void)delContact:(ContactInfo*)contact
{
	[contacts removeObjectIdenticalTo:contact];
}

- (NSString*)description
{
	NSMutableString* desc = [[NSMutableString alloc] init];
	for(ContactInfo* contact in contacts)
	{
		[desc appendFormat:@"%@\n",contact];
	}
	[desc appendFormat:@"共%d个学员", (int)contacts.count];
	return [desc copy];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:contacts forKey:@"contacts"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if(self)
	{
		contacts = [aDecoder decodeObjectForKey:@"contacts"];
	}
	return self;
}

@end
