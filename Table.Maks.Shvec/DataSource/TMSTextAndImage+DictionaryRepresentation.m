//
//  TMSTextAndImage+DictionaryRepresentation.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/10/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "TMSTextAndImage+DictionaryRepresentation.h"

@implementation TMSTextAndImage (DictionaryRepresentation)

+ (NSDictionary *)dictionaryRepresentation: (TMSTextAndImage *)model
{
    NSDictionary *dictionary = @{@"text" : model.text,@"imageName" : model.imageName};
    return dictionary;
}

@end
