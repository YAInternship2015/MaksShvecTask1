//
//  TMSDataSource.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSDataSource.h"
#import "NSString+Path.h"

@implementation TMSDataSource

- (TMSDataSource *)initFromPlist
{
    self = [super init];
    if (!self.arrayOfData)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TMSData" ofType:@"plist"];
        self.arrayOfData = [[NSMutableArray alloc] initWithContentsOfFile:path];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadArrayWithPlist) name:@"ContenDidChange" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (NSUInteger)numberOfObjects
{
    return [self.arrayOfData count];
}

//- (TMSTextAndImage *)objectAtIndex: (NSUInteger)indexOfObject
//{
//    if (self.arrayOfData && ([self.arrayOfData count] > indexOfObject)) {
//        return [self.arrayOfData objectAtIndex:indexOfObject];
//    }
//    NSLog(@"objectAtIndex: %ui - wrong index for arrayOfData", indexOfObject);
//    return nil;
//}

//- (NSMutableArray *)loadPlist
//{
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [path objectAtIndex:0];
//    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TMSData.plist"];
//    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
//    {
//        plistPath = [[NSBundle mainBundle]pathForResource:@"TMSData" ofType:@"plist"];
//    }
//    
//    NSData *plistXML = [[NSFileManager defaultManager]contentsAtPath:plistPath];
//    NSString *errorDesc = nil;
//    NSPropertyListFormat format;
//    
//    NSMutableArray *arrayOfPlist = (NSMutableArray *)[NSPropertyListSerialization propertyListWithData:plistXML options:NSPropertyListMutableContainersAndLeaves format:&format error:nil];
//    
//    if (!arrayOfPlist)
//    {
//        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, (unsigned long)format);
//    }
//    return arrayOfPlist;
//}

+ (void)copyDataPlistToDocumentFolder {
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error;
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *doumentDirectoryPath = [pathsArray objectAtIndex:0];
    
    NSString *destinationPath= [doumentDirectoryPath stringByAppendingPathComponent:@"TMSData.plist"];
    
    NSLog(@"plist path %@",destinationPath);
    if ([fileManger fileExistsAtPath:destinationPath])
    {
        return;
    }
    NSString *sourcePath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"TMSData.plist"];
                          
                          [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:&error];
}

+ (void)addObject:(TMSTextAndImage *)object
{
    NSDictionary *newModel = @{@"stringName" : object.stringText,
                               @"stringPic" : object.stringPic};
    
    NSString *pathToDoc = [NSString stringWithFormat:@"%@/%@", [NSString applicationDocumentsDirectory], @"TMSData.plist"];
    NSMutableArray *tempModelsArray = [NSMutableArray arrayWithContentsOfFile:pathToDoc];
    [tempModelsArray addObject:newModel];
    
    if ([tempModelsArray writeToFile:pathToDoc atomically:YES])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ContentDidChange" object:nil];
    }
    else
    {
        NSLog(@"Character not added");
    }
}

- (void)loadArrayWithPlist
{
    
}

@end
