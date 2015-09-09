//
//  NSString+Validation.h
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning эта логика должна быть не в категории к NSString, а в отдельном классе-валидаторе. Категория немного расширяет функциональные возможности класса, но не придаем ему еще новых ответственностей

@interface NSString (Validation)

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error;

@end
