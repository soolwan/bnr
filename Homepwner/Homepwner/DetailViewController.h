//
//  DetailViewController.h
//  Homepwner
//
//  Created by Sean Coleman on 7/2/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate,
UITextFieldDelegate, UIPopoverControllerDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;

    UIPopoverController *imagePickerPopover;
}

@property (nonatomic) BNRItem *item;

@property (nonatomic, copy) void (^dismissBlock)(void);  // Gets created in itemsViewController
                                                         // because that's where the tableView is.

// Designated initializer.
- (id)initForNewItem:(BOOL)isNew;

- (IBAction)takePicture:(id)sender;

// First we changed DetailView to subclass UIControl instead
// of UIView in the identity inspector.
// Then we create an action for touchUpInside and dismiss
// the keyboard in that action method.
- (IBAction)backgroundTapped:(id)sender;

@end
