//
//  ContactInfoController.h
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"

@interface ContactInfoController : UIViewController

@property(nonatomic,strong) ContactInfo* contact;
@property (strong, nonatomic) void (^contactChanged)(ContactInfo* contact);

@end
