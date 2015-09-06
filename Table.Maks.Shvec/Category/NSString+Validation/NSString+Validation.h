//
//  NSString+Validation.h
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error;

@end
