//
//  ContactManage.m
//  ContactManage
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactManage.h"
#import "IDNFoundation.h"

@implementation ContactManage
{
	NSMutableArray* contacts;
	NSPointerArray* observers;
}

- (instancetype)init
{
	self = [super init];
	if(self)
	{
		contacts = [[NSMutableArray alloc] init];
		observers = [NSPointerArray weakObjectsPointerArray];
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
	[self notifyObserversWithChangedContact:contact];
}

- (void)delContact:(ContactInfo*)contact
{
	[contacts removeObjectIdenticalTo:contact];
	[self notifyObserversWithChangedContact:contact];
}

- (void)contactChanged:(ContactInfo*)contact
{
	if([contacts indexOfObject:contact]==NSNotFound)
		return;
	[self notifyObserversWithChangedContact:contact];
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
		observers = [NSPointerArray weakObjectsPointerArray];
	}
	return self;
}

#pragma mark Observers

- (void)addContactsObserver:(id<ContactManageObserver>)observer
{
	if([observers containsPointer:(__bridge void *)(observer)])//已经是观察者了
		return;
	[observers addPointer:(__bridge void *)(observer)];
}
- (void)delContactsObserver:(id<ContactManageObserver>)observer
{
	[observers removePointerIdentically:(__bridge void *)(observer)];
}
- (void)notifyObserversWithChangedContact:(ContactInfo*)contact
{
	for (id<ContactManageObserver> observer in observers) {
		if(observer==nil)
			continue;

		if([observer respondsToSelector:@selector(contactManager:contactUpdated:)])
			[observer contactManager:self contactUpdated:contact];
	}
	[observers compact];
}

@end
