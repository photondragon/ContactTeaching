//
//  ImageViewController.h
//  Contacts
//
//  Created by photondragon on 15/4/19.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyImageViewer.h"

@interface ImageViewController : UIViewController

@property(nonatomic,strong,readonly) MyImageViewer* imageViewer;

@end
