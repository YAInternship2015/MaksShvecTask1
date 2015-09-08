//
//  TMSViewControllerWithAddFunc.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/28/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "TMSViewControllerWithAddFunc.h"

@interface TMSViewControllerWithAddFunc () <UITextFieldDelegate>

#warning по нашим гайдланам (nonatomic, weak)
@property (weak, nonatomic) IBOutlet UITextField *textField;
#warning аутлет на кнопку Вы нигде не используете, можно было не проводить его
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation TMSViewControllerWithAddFunc

#warning такой метод надо удалять
- (void)viewDidLoad
{
    [super viewDidLoad];
}

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

- (IBAction)saveNewObject:(id)sender
{
    NSError *error = NULL;
    if ([NSString isValidModelTitle:self.textField.text error:&error])
    {
        [TMSDataSource addObject: [TMSTextAndImage modelWithName:self.textField.text]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
