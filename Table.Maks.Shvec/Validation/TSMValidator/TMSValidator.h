//
//  TSMValidator.h
//  Table.Maks.Shvec
//
//  Created by Maks on 9/10/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TMSValidator : NSObject

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error;

@end
