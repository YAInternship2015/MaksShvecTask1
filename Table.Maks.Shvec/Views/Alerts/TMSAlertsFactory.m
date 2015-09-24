//
//  TMSAlerts.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSAlertsFactory.h"

@implementation TMSAlertsFactory

#pragma mark -  NSString validation alert

#warning { должны быть на той же строке, что и имя метода
+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
#warning     UIAlertController *alert =
    UIAlertController *alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
#warning @"OK" должна быть в Localizable.strings
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    return alert;
}

@end
