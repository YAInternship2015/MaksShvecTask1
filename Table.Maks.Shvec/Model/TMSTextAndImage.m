//
//  TMSTextAndImage.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/15/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "TMSTextAndImage.h"

@implementation TMSTextAndImage

+ (TMSTextAndImage *)modelWithName: (NSString *)name
{
    TMSTextAndImage *model = [[TMSTextAndImage alloc]init];
    model.stringText = name;
    model.stringPic = @"noPic";
    return model;
}


@end
 