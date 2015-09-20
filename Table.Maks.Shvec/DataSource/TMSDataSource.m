//
//  TMSDataSource.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSDataSource.h"
#import "NSString+Path.h"
#import "TMSTextAndImage+DictionaryRepresentation.h"

@interface TMSDataSource ()

@property (nonatomic, strong) NSArray *arrayOfData;

@end

@implementation TMSDataSource

#pragma mark - DataSource init methods

- (instancetype)initWithDelegate: (id<TMSDataSourceDelegate>)delegate
{
    self = [self init];
    if (self)
    {
        self.delegate = delegate;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataArrayWithPlist) name:contentDidChange object:nil];
        [self loadDataArrayWithPlist];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - DataSource methods

- (void)loadDataArrayWithPlist
{
    self.arrayOfData = [NSArray arrayWithContentsOfFile:[NSString pathToPlist]];
    [self.delegate dataWasChanged:self];
}

- (void)reloadDataArrayWithPlist
{
    [self loadDataArrayWithPlist];
}

- (NSUInteger)numberOfObjects
{
    return [self.arrayOfData count];
}

- (TMSTextAndImage *)indexOfObject:(NSInteger)index
{
    TMSTextAndImage *model = [[TMSTextAndImage alloc]init];
    NSMutableDictionary *dictModel = (NSMutableDictionary *)[self.arrayOfData objectAtIndex:index];
    model.text = [dictModel objectForKey:@"text"];
    model.imageName = [dictModel objectForKey:@"imageName"];
    return model;
}

#pragma mark - Work with plist methods

+ (void)addObject:(TMSTextAndImage *)object
{
    NSDictionary *newModel = @{@"text" : object.text,
                               @"imageName" : object.imageName};
    
    NSMutableArray *tempModelsArray = [NSMutableArray arrayWithContentsOfFile:[NSString pathToPlist]];
    [tempModelsArray addObject:newModel];
    
    if ([tempModelsArray writeToFile:[NSString pathToPlist] atomically:YES])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentDidChange object:nil];
    }
}

+ (void)copyDataPlistToDocumentFolder {
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error;
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *doumentDirectoryPath = [pathsArray objectAtIndex:0];
    
    NSString *destinationPath= [doumentDirectoryPath stringByAppendingPathComponent:plistNameAndType];
    
    NSLog(@"plist path %@",destinationPath);
    if ([fileManger fileExistsAtPath:destinationPath])
    {
        return;
    }
    NSString *sourcePath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:plistNameAndType];
    
    [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:&error];
}



@end
