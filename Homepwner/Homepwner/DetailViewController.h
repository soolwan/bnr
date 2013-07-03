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
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
}

@property (nonatomic) BNRItem *item;

- (IBAction)takePicture:(id)sender;

// First we changed DetailView to subclass UIControl instead
// of UIView in the identity inspector.
// Then we create an action for touchUpInside and dismiss
// the keyboard in that action method.
- (IBAction)backgroundTapped:(id)sender;

@end
