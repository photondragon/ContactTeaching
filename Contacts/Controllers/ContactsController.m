//
//  ContactsController.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactsController.h"
#import "ContactManage.h"
#import "ContactInfoController.h"
#import "MyModels.h"
#import "ContactNewController.h"
#import "IDNFoundation.h"
#import "ContactCell.h"

@interface ContactsController ()
<ContactManageObserver>

@end

@implementation ContactsController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact:)];

	[self.tableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];

	[[MyModels contactManager] addContactsObserver:self];
}

- (void)addContact:(id)sender
{
	ContactNewController* c = [[ContactNewController alloc] init];
	UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:c];
	[self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MyModels contactManager].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];

	ContactInfo* contact = [[MyModels contactManager] contactAtIndex:indexPath.row];
	cell.contact = contact;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ContactInfo* contact = [[MyModels contactManager] contactAtIndex:indexPath.row];

	ContactInfoController* infoController = [[ContactInfoController alloc] init];
	infoController.contact = contact;

	[self.navigationController pushViewController:infoController animated:YES];
}

// 实现此数据源方法，在条目上左划就会出现Delete按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		ContactInfo* info = [[MyModels contactManager] contactAtIndex:indexPath.row];

		[NSFileManager removeDocumentFile:info.headImageUrl];

		[[MyModels contactManager] delContactsObserver:self];
		[[MyModels contactManager] delContact:info];
		[[MyModels contactManager] addContactsObserver:self];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
	else if (editingStyle == UITableViewCellEditingStyleInsert)
	{
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark ContactManageObserver

- (void)contactManager:(ContactManage *)manager contactUpdated:(ContactInfo *)contact
{
	[self.tableView reloadData];
}

@end
