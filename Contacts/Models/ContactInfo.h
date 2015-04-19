//
//  Student.h
//  StudentManage
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject
<NSCoding>

@property(nonatomic,strong) NSString* name;
@property(nonatomic) NSString* phone;
@property(nonatomic) NSString* headImageUrl;

@end
