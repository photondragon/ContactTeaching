//
//  BreviaryCell.h
//  Contacts
//
//  Created by photondragon on 15/5/9.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreviaryCell : UICollectionViewCell

- (void)setImagePath:(NSString*)imagefile;//设置cell要加载的图像文件
- (void)setImagePath:(NSString*)imagefile placeHolder:(UIImage*)placeHolder;//设置cell要加载的图像文件，placeHolder占位图，在图像加载过程中显示

@end
