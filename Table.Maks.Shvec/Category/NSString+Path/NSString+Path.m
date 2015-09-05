//
//  NSString+Path.m
//  Table.Maks.Shvec
//
//  Created by Maks on 9/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

+ (NSString *) documentsFolderPlistPath
{
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathsArray objectAtIndex:0];
    NSString *plistName = [[nameOfPlist stringByAppendingString:@"."]stringByAppendingString:typeOfPlist];
    return [documentsDirectory stringByAppendingPathComponent:plistName];
}

+ (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
    return basePath;
}

@end
