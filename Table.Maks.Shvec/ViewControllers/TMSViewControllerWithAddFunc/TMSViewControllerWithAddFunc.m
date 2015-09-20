//
//  TMSViewControllerWithAddFunc.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/28/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "TMSViewControllerWithAddFunc.h"
#import "TMSValidator.h"
#import "TMSDataSource.h"
#import "TMSTextAndImage.h"

@interface TMSViewControllerWithAddFunc () <UITextFieldDelegate>

@property (nonatomic ,weak) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation TMSViewControllerWithAddFunc


#pragma - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard
{
    [self.textField resignFirstResponder];
}

#pragma - Actions

- (IBAction)saveNewObject:(id)sender {
    
    NSError *error = NULL;
    if (![TMSValidator isValidModelTitle:self.textField.text error:&error]) {
        
        
        UIAlertController *alert = [TMSAlertsFactory showAlertWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Error", nil)] message:[error localizedDescription]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        TMSTextAndImage *modelToAdd = [[TMSTextAndImage alloc]init];
        [TMSDataSource addObject: [modelToAdd initModelWithName:self.textField.text]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
