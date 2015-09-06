//
//  TMSAlerts.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSAlerts.h"

@implementation TMSAlerts

+ (void)showAlertWithMethodIsValidModelTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please type more than 3 symblos..." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    
}

@end
