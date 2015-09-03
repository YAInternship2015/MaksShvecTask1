//
//  TMSViewControllerWithAddFunc.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/28/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "TMSViewControllerWithAddFunc.h"

@interface TMSViewControllerWithAddFunc () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation TMSViewControllerWithAddFunc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard
{
    [self.textField resignFirstResponder];
}

- (IBAction)saveNewObject:(id)sender
{
    [TMSDataSource addObject: [TMSTextAndImage modelWithName:self.textField.text]];
}




@end
