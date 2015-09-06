//
//  NSString+Validation.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

#pragma mark - NSString validation methods

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error
{
    if ([title length] < 3)
    {
        NSString *errorMessage;
        NSInteger errorCode = 0;
        errorMessage = @"Please type more than 3 symblos...";
        errorCode = 77;
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:@"TestTask2" code:errorCode userInfo:userInfo];
            
        }
        [TMSAlerts showAlertWithMethodIsValidModelTitle];
        return NO;
    }
    return YES;
}


@end
