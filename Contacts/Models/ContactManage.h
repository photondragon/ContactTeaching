//
//  ContactManage.h
//  ContactManage
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactInfo.h"

@protocol ContactManageObserver;

@interface ContactManage : NSObject
<NSCoding>

@property(nonatomic,readonly) NSUInteger count;//联系人个数

- (ContactInfo*)contactAtIndex:(NSUInteger)index;

- (void)addContact:(ContactInfo*)contact;
- (void)delContact:(ContactInfo*)contact;
- (void)contactChanged:(ContactInfo*)contact;
//- (ContactInfo*)findContactByName:(NSString*)name;

- (void)addContactsObserver:(id<ContactManageObserver>)observer;//添加观察者。不会增加observer对象的引用计数，当observer对象引用计数变为0时，会自动删除观察者对象，不用显式删除。
- (void)delContactsObserver:(id<ContactManageObserver>)observer;//删除观察者

@end

@protocol ContactManageObserver <NSObject>
@optional
- (void)contactManager:(ContactManage*)manager contactUpdated:(ContactInfo*)contact; //商品信息更新了（新增、修改）

@end
