//
//  TMSDataSource.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSDataSource.h"

@implementation TMSDataSource

- (instancetype)initFromFile:(NSString *)fileName ofType: (NSString *)fileType
{
    self = [super init];
    if (self)
    {
        NSBundle *appBundle = [NSBundle mainBundle];
        NSString *pathToData = [appBundle pathForResource:fileName ofType:fileType];
        if ([self loadDataFromFile:pathToData] == NO) {
            NSLog(@"couldn't find data in '%@' file",pathToData);
            return nil;
        }
    }
    return self;
}

- (BOOL)loadDataFromFile:(NSString *)pathToData
{
    NSArray *rawData = [NSArray arrayWithContentsOfFile:pathToData];
    if (rawData)
    {
        self.arrayOfData = [NSMutableArray array];
        TMSTextAndImage *objectWithData = [TMSTextAndImage new];
        [self.arrayOfData addObject:objectWithData];
        return YES;
    }
    return NO;
}

- (NSUInteger)numberOfObjects
{
    return [self.arrayOfData count];
}

- (TMSTextAndImage *)objectAtIndex: (NSUInteger)indexOfObject
{
    if (self.arrayOfData && ([self.arrayOfData count] > indexOfObject)) {
        return [self.arrayOfData objectAtIndex:indexOfObject];
    }
    NSLog(@"objectAtIndex: %ui - wrong index for arrayOfData", indexOfObject);
    return nil;
}

- (NSDictionary *)loadPlist
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TMSData.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle]pathForResource:@"TMSData" ofType:@"plist"];
    }
    
    NSData *plistXML = [[NSFileManager defaultManager]contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    NSDictionary *dictionaryOfPlist = (NSDictionary *)[NSPropertyListSerialization propertyListWithData:plistXML options:NSPropertyListMutableContainersAndLeaves format:&format error:nil];
    
    if (!dictionaryOfPlist)
    {
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, (unsigned long)format);
    }
    return dictionaryOfPlist;
}

@end
