//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Sean Coleman on 6/27/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsViewController : UITableViewController
{
    IBOutlet UIView *headerView;  // Strong reference. Top level item in .xib.
}

- (UIView *)headerView;
- (IBAction)addNewItem:(id)sender;
- (IBAction)toggleEditingMode:(id)sender;

@end
