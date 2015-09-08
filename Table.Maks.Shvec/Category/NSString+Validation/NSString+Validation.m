//
//  NSString+Validation.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

+ (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error
#warning открывающаяся фигурная скобка должна быть на той же строке, что и имя метода. Это касается также и циклов, и if'ов. Исправьте по всему проекту
{
#warning цифру 3 надо объявить константой в классе-валидаторе
    if ([title length] < 3)
    {
#warning незачем вначале объявлять переменные, и затем присваивать им значения. Инициализируйте сразу со значениями
        NSString *errorMessage;
        NSInteger errorCode = 0;
        
#warning тексты, которые создаются в коде и которые увидит юзер в UI, должны быть объявлены в файле Localizable.strings. Что это за файл и зачем он нужен очень легко найти в гугле
        errorMessage = @"Please type more than 3 symblos...";
        errorCode = 77;
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:@"TestTask2" code:errorCode userInfo:userInfo];
            
        }
#warning здесь нарушение ответственностей. Отображать в UI ошибку должен контроллер
        [TMSAlerts showAlertWithMethodIsValidModelTitle];
        return NO;
    }
    return YES;
}


@end
