//
//  ContactInfoController.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactInfoController.h"
#import "IDNImagePickerController.h"
#import "ImageViewController.h"
#import "IDNFoundation.h"
#import "MyModels.h"
#import "UIBezierPath+IDNExtend.h"

@interface ContactInfoController ()
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property(nonatomic,weak) IBOutlet UITextField* textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHead;

@end

@implementation ContactInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"联系人信息";
	self.edgesForExtendedLayout = 0;

	NSLog(@"%@", [NSString documentsPath]);

	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	if(editing)
	{
		self.textFieldName.enabled = YES;
		self.textFieldPhone.enabled = YES;
	}
	else
	{
		self.contact.name = self.textFieldName.text;
		self.contact.phone = self.textFieldPhone.text;
		[[MyModels contactManager] contactChanged:self.contact];

		self.textFieldName.enabled = NO;
		self.textFieldPhone.enabled = NO;
	}
}

- (IBAction)btnImageClicked:(id)sender {
	if(self.editing)
	{
		UIImagePickerController* picker = [[IDNImagePickerController alloc] init];
		picker.delegate = self;
		[self presentViewController:picker animated:YES completion:nil];
	}
	else
	{
		ImageViewController* c = [[ImageViewController alloc] init];
		c.imageViewer.imagePath = [NSString documentsPathWithFileName:self.contact.headImageUrl];
		c.title = self.contact.name;
		[self.navigationController pushViewController:c animated:YES];
	}
}

- (void)setContact:(ContactInfo *)contact
{
	_contact = contact;

	[self view];

	self.textFieldName.text = contact.name;
	_textFieldPhone.text = contact.phone;
	if(contact.headImageUrl.length)
		self.imageViewHead.image = [UIImage imageWithContentsOfFile:[NSString documentsPathWithFileName:contact.headImageUrl]];
	else
		self.imageViewHead.image = [self defaultHeadImage];//[UIImage imageNamed:@"defaultHead.png"];

//	self.title = contact.name;
}

- (UIImage*)defaultHeadImage
{
	CGSize framesize = CGSizeMake(512, 512);
	UIGraphicsBeginImageContext(framesize);//创建一个新图像上下文

	CGFloat width = framesize.width<framesize.height? framesize.width : framesize.height;

	UIBezierPath* path = [UIBezierPath bezierPath];
	[path addRect:CGRectMake((framesize.width-width)/2.0, (framesize.height-width)/2.0, width, width)];
	[[UIColor lightGrayColor] setFill];
	[path fill];
	[path removeAllPoints];

	[path addArcWithCenter:CGPointMake(framesize.width/2.0, framesize.height*0.42) radius:width/5.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
	[path addArcWithCenter:CGPointMake(framesize.width/2.0, framesize.height) radius:width/2.5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
	[[UIColor grayColor] setFill];
	[path fill];

	UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];

	UIImage* image = info[UIImagePickerControllerOriginalImage];
	if(image==nil)
		return;

	NSString* file = [NSString stringWithFormat:@"head/%@.jpg",[[NSDate date] stringWithFormat:@"yyyyMMddhhmmss"]];
	NSData* imageData = UIImageJPEGRepresentation(image, 0.8);
	if([imageData writeToDocumentFile:file]==NO)
		return;

	[NSFileManager removeDocumentFile:self.contact.headImageUrl];

	self.contact.headImageUrl = file;
	self.imageViewHead.image = image;
}

- (IBAction)blankTapped:(id)sender {
	[self.textFieldName resignFirstResponder];
	[self.textFieldPhone resignFirstResponder];
}

@end
