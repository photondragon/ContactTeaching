//
//  MyImageViewer.h
//  Contacts
//
//  Created by photondragon on 15/4/26.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageViewer : UIView

@property(nonatomic,strong) NSString* imagePath;

@property(nonatomic) BOOL minimized;
@property(nonatomic) BOOL maximized;
@property(nonatomic) CGFloat zoomScale;

- (void)setZoomScale:(CGFloat)zoomScale animated:(BOOL)animated;

@end
