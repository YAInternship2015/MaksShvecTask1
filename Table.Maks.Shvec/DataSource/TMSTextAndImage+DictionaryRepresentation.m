//
//  TMSTextAndImage+DictionaryRepresentation.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/10/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "TMSTextAndImage+DictionaryRepresentation.h"

@implementation TMSTextAndImage (DictionaryRepresentation)

+ (TMSTextAndImage *)dictionaryRepresentation: (NSDictionary *)item
{
    TMSTextAndImage *model = [[TMSTextAndImage alloc]init];
    model.stringText = item[@"stringName"];
    model.stringPic = item[@"stringPic"];
    
    return model;
}

@end
