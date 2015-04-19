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
#import "NSString+IDNExtend.h"

@interface ContactsController ()
//@property(nonatomic,strong)ContactManage* contactManager;
@end

@implementation ContactsController

- (void)viewDidLoad {
    [super viewDidLoad];

//	for (int i=0; i<4; i++) {
//		ContactInfo* contact = [[ContactInfo alloc] init];
//		contact.name = [NSString stringWithFormat:@"Name%d", i];
//		contact.phone = [NSString stringWithFormat:@"1881234000%d", i];
//
//		[[MyModels contactManager] addContact:contact];
//	}

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact:)];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.tableView reloadData];
}

- (void)addContact:(id)sender
{
	ContactNewController* c = [[ContactNewController alloc] init];
	UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:c];
	[self presentViewController:nav animated:YES completion:nil];

//	ContactInfo* contact = [[ContactInfo alloc] init];
//	contact.name = @"Name";
//	contact.phone = @"18812340000";
//	[[MyModels contactManager] addContact:contact];
//
//	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MyModels contactManager].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];

	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellStyleValue1"];

	ContactInfo* contact = [[MyModels contactManager] contactAtIndex:indexPath.row];
	cell.textLabel.text = contact.name;
	cell.detailTextLabel.text = contact.phone;
	if(contact.headImageUrl.length)
		cell.imageView.image = [UIImage imageWithContentsOfFile:[NSString documentsPathWithFileName:contact.headImageUrl]];
	else
		cell.imageView.image = [UIImage imageNamed:@"defaultHead.png"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ContactInfo* contact = [[MyModels contactManager] contactAtIndex:indexPath.row];

	ContactInfoController* infoController = [[ContactInfoController alloc] init];
	infoController.contact = contact;

	[self.navigationController pushViewController:infoController animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// 实现此数据源方法，在条目上左划就会出现Delete按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		ContactInfo* info = [[MyModels contactManager] contactAtIndex:indexPath.row];
		[[MyModels contactManager] delContact:info];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
	else if (editingStyle == UITableViewCellEditingStyleInsert)
	{
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
