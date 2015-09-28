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

+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Ok", nil)]
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    return alert;
}

@end
