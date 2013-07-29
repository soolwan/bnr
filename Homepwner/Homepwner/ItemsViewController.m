//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Sean Coleman on 6/27/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController

// Ensure that all instances of ItemsViewController use the
// UITableViewStyleGrouped style, no matter what initialization
// message is sent to it.
- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {

        // We can create items now, so we don't need this.
        // Create 5 BNRItems in the BNRItemStore.
        //for (int i = 0; i < 5; i++) {
        //    [[BNRItemStore sharedStore] createItem];
        //}

        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"Homepwner"];

        // Create a new bar button item that will send
        // addNewItem: to ItemsViewController.
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];

        // Set this bar button item as the right item in the navigationItem.
        [[self navigationItem] setRightBarButtonItem:bbi];

        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    }

    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

//- (UIView *)headerView
//{
//    // If we haven't loaded the headerView yet...
//    if (!headerView) {
//        // Load HeaderView.xib
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//
//    return headerView;
//}

#pragma mark - UITableView Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create instance of UITableViewCell with default appearance. Nope - need reuse.
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];

    // Check for a reusable cell first. use that if it exists.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];

    // If there is no reusable cell of this type, create a new one.
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }

    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableView.
    BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];

    [[cell textLabel] setText:[p description]];

    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return [self headerView];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    // The height of the header view should be determined from the height of the view in the XIB file.
//    return [[self headerView] bounds].size.height;
//}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BNRItemStore *ps = [BNRItemStore sharedStore];
        NSArray *items = [ps allItems];
        BNRItem *p = [items objectAtIndex:[indexPath row]];
        [ps removeItem:p];

        // We also remove that row from the table view with an animation.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row]
                                        toIndex:[destinationIndexPath row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //DetailViewController *detailViewController = [[DetailViewController alloc] init];
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:NO];  // New initializer

    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = [items objectAtIndex:[indexPath row]];

    // Give detail view controller a pointer to the item object in row.
    [detailViewController setItem:selectedItem];

    // Push it onto the top of the navigation controller's stack.
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

//- (IBAction)toggleEditingMode:(id)sender
//{
//    // If we are currently in editing mode...
//    if ([self isEditing]) {
//        // Change button text to inform user of state.
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        // Turn off editing mode.
//        [self setEditing:NO animated:YES];
//    } else {
//        // Change text of button to inform user of state.
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        // Enter editing mode.
//        [self setEditing:YES animated:YES];
//    }
//}

- (IBAction)addNewItem:(id)sender
{
    // Make a new index path for the 0th section, last row.

    // Can't do this. The store has to have a BNRItem for internal consistency.
    // int lastRow = [[self tableView] numberOfRowsInSection:0];

    // Create a new BNRItem and add it to the store.
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];

    // Figure out where that item is in the array.
    //int lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    //NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    // Insert this new row into the table.
    //[[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
    //                        withRowAnimation:UITableViewRowAnimationTop];

    // We are going to present the detail view when we add a new item, rather than
    // merely inserting a row.

    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:YES];

    [detailViewController setItem:newItem];

    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailViewController];

    [navController setModalPresentationStyle:UIModalPresentationFormSheet];

    [self presentViewController:navController
                       animated:YES
                     completion:nil];
}

@end
