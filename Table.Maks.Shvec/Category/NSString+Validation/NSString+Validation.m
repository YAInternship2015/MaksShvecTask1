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
#warning открывающаяся фигурная скобка должна быть на той же строке, что и имя метода. Это касается также и циклов, и if'ов. Исправьте по всему проекту
{
#warning цифру 3 надо объявить константой в классе-валидаторе
    if ([title length] < 3)
    {
#warning незачем вначале объявлять переменные, и затем присваивать им значения. Инициализируйте сразу со значениями
        
#warning тексты, которые создаются в коде и которые увидит юзер в UI, должны быть объявлены в файле Localizable.strings. Что это за файл и зачем он нужен очень легко найти в гугле
        NSString *errorMessage = [NSString stringWithFormat: NSLocalizedString(@"Please type more than 2 symblos", nil)];
        NSInteger errorCode = 77;
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:@"TestTask2" code:errorCode userInfo:userInfo];
            
        }
        
        return NO;
    }
    return YES;
}


@end
