//
//  BreviaryController.m
//  Contacts
//
//  Created by photondragon on 15/5/9.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "BreviaryController.h"
#import "IDNFoundation.h"
#import "BreviaryCell.h"

@interface BreviaryController ()
{
	NSString* imagesPath; //图像目录（应用的Documents目录）
	NSArray* arrayImageFiles; //所有图像文件的文件名数组
	UIImage* imageLoading; //显示“正在加载。。。”的图像
	CGSize imageViewSize;
}
@end

@implementation BreviaryController

static NSString * const reuseIdentifier = @"BreviaryCell";

- (instancetype)init
{
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	imageViewSize.width = (int)((screenSize.width<screenSize.height?screenSize.width:screenSize.height)/5);
	imageViewSize.height = imageViewSize.width;

	UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
	flowLayout.itemSize = imageViewSize;
	flowLayout.minimumLineSpacing = 0;
	flowLayout.minimumInteritemSpacing = 0;
	self = [super initWithCollectionViewLayout:flowLayout];
	if(self)
	{

	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	imageLoading = [UIImage imageNamed:@"loading.jpg"];
	imagesPath = [NSString documentsPath];//将应用的Documents目录设置为图像目录
	arrayImageFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imagesPath error:nil];//获取图像目录下的文件名列表

    [self.collectionView registerClass:[BreviaryCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrayImageFiles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BreviaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

	cell.contentView.backgroundColor = [UIColor redColor];
	[cell setImagePath:[NSString stringWithFormat:@"%@/%@",imagesPath,arrayImageFiles[indexPath.row]] placeHolder:imageLoading];

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
