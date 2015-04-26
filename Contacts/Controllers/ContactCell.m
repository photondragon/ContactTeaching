//
//  ContactCell.m
//  Contacts
//
//  Created by photondragon on 15/4/26.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactCell.h"
#import "IDNFoundation.h"

@interface ContactCell()

@property(nonatomic,weak) IBOutlet UIImageView* imageViewHead;
@property(nonatomic,weak) IBOutlet UILabel* labelName;
@property(nonatomic,weak) IBOutlet UILabel* labelPhone;

@end

@implementation ContactCell

- (void)awakeFromNib
{
	[super awakeFromNib];

	self.imageViewHead.layer.cornerRadius = 8;
}

- (void)setContact:(ContactInfo *)contact
{
	_contact = contact;

	self.labelName.text = contact.name;
	self.labelPhone.text = contact.phone;
	if(contact.headImageUrl.length)
		self.imageViewHead.image = [UIImage imageWithContentsOfFile:[NSString documentsPathWithFileName:contact.headImageUrl]];
	else
		self.imageViewHead.image = [UIImage imageNamed:@"defaultHead.png"];
}

@end
