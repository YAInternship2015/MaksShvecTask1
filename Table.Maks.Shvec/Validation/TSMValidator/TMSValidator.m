//
//  TSMValidator.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/10/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSValidator.h"

NSInteger const minLenghtAllowed = 3;

@implementation TMSValidator

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error {
    
    if ([title length] < minLenghtAllowed){
        
        NSString *errorMessage = [NSString stringWithFormat: NSLocalizedString(@"Please type more than 2 symbols", nil)];
        NSInteger errorCode = 77;
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        if (error != NULL){
            *error = [NSError errorWithDomain:@"TestTask2" code:errorCode userInfo:userInfo];
        }
        
        return NO;
    }
    return YES;
}


@end
