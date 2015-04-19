//
//  ContactNewController.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactNewController.h"
#import "IDNFoundation.h"
#import "IDNImagePickerController.h"
#import "MyModels.h"

@interface ContactNewController ()
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property(nonatomic,strong) ContactInfo* contact;

@property(nonatomic,weak) IBOutlet UITextField* textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHead;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIControl *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfBottom;
@end

@implementation ContactNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"新建联系人";
	self.edgesForExtendedLayout = 0;

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];

	CGSize contentSize = CGSizeMake(self.scrollView.frame.size.width, 400);
	self.contentView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
	self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.scrollView addSubview:self.contentView];
	self.scrollView.contentSize = contentSize;

	self.contact = [[ContactInfo alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
	[super viewWillDisappear:animated];
}

- (void)keyboardWillChangeFrame:(NSNotification*)note
{
	NSDictionary *userInfo = note.userInfo;

	NSNumber *animationDurationNumber = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	NSTimeInterval animationDuration = [animationDurationNumber doubleValue];

	NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardFrame = [aValue CGRectValue];
	CGRect keyboardRect = [self.view convertRect:keyboardFrame fromView:nil];//获取键盘坐标，并由屏幕坐标转为view的坐标
	CGRect containerRect = self.view.bounds;
	CGFloat bottomDistance = containerRect.size.height - keyboardRect.origin.y;

	if(bottomDistance>0)//弹出键盘
	{
		self.constraintOfBottom.constant = bottomDistance;
		[UIView animateWithDuration:animationDuration animations:^{
			[self.view layoutIfNeeded];
		}];
	}
	else//收起键盘
	{
		self.constraintOfBottom.constant = 0;
		[UIView animateWithDuration:animationDuration animations:^{
			[self.view layoutIfNeeded];
		}];
	}
}

- (void)cancel:(id)sender
{
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)save:(id)sender
{
	self.contact.name = self.textFieldName.text;
	self.contact.phone = self.textFieldPhone.text;

	[[MyModels contactManager] addContact:self.contact];

	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
	
	[NSFileManager removeDocumentFile:self.contact.headImageUrl];

	self.contact.headImageUrl = file;
	self.imageViewHead.image = image;
}

- (IBAction)blankTapped:(id)sender {
	[self.textFieldName resignFirstResponder];
	[self.textFieldPhone resignFirstResponder];
}

@end
