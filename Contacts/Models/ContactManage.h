//
//  ContactManage.h
//  ContactManage
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactInfo.h"

@interface ContactManage : NSObject
<NSCoding>

@property(nonatomic,readonly) NSUInteger count;//联系人个数

- (ContactInfo*)contactAtIndex:(NSUInteger)index;

- (void)addContact:(ContactInfo*)contact;
- (void)delContact:(ContactInfo*)contact;
//- (ContactInfo*)findContactByName:(NSString*)name;

@end
