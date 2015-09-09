//
//  NSString+Path.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

+ (NSString *)pathToPlist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
#warning имя файла необходимо объявить константой
    NSString *pathToPlist = [NSString stringWithFormat:@"%@/%@", basePath, @"TMSData.plist"];
    return pathToPlist;
}

@end
