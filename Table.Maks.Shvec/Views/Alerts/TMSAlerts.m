//
//  TMSAlerts.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSAlerts.h"

@implementation TMSAlerts

#pragma mark -  NSString validation alert

+ (void)showAlertWithMethodIsValidModelTitle
{
#warning более гибким было бы решение, если бы этот метод принимал NSError параметром
#warning опять же, все следующие тексты должны находиться в Localizable.strings
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please type more than 3 symblos..." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Plist alerts
+ (void)showAlertErrorAddingObjectToPlist
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something goes wrong..." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

+ (void)showAlertObjectAdded
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:@"Object added" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];    
}

@end
