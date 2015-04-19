//
//  ContactInfoController.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactInfoController.h"
#import "NSString+IDNExtend.h"
#import "NSData+IDNExtend.h"
#import "NSDate+IDNExtend.h"
#import "IDNImagePickerController.h"

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
}

- (IBAction)btnImageClicked:(id)sender {
	UIImagePickerController* picker = [[IDNImagePickerController alloc] init];
	picker.delegate = self;
	[self presentViewController:picker animated:YES completion:nil];
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
		self.imageViewHead.image = [UIImage imageNamed:@"defaultHead.png"];

//	self.title = contact.name;
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
	
	self.contact.headImageUrl = file;
	self.imageViewHead.image = image;
}

@end
