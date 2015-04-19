//
//  MyModels.h
//  Contacts
//
//  Created by photondragon on 15/4/12.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactManage.h"

@interface MyModels : NSObject

+ (ContactManage*)contactManager;
+ (void)save;

@end
