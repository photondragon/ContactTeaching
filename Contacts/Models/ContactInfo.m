//
//  Student.m
//  StudentManage
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactInfo.h"

@implementation ContactInfo

- (NSString*)description
{
	return [NSString stringWithFormat:@"姓名：%@ 电话：%@", _name, _phone];
}

//编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.name forKey:@"name"];
	[aCoder encodeObject:self.phone forKey:@"phone"];
	[aCoder encodeObject:self.headImageUrl forKey:@"headImageUrl"];
}

//解码
- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if(self)
	{
		self.name = [aDecoder decodeObjectForKey:@"name"];
		self.phone = [aDecoder decodeObjectForKey:@"phone"];
		self.headImageUrl = [aDecoder decodeObjectForKey:@"headImageUrl"];
	}
	return self;
}

@end
