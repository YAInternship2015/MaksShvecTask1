//
//  TMSDataSource.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSDataSource.h"
#import "NSString+Path.h"

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

- (NSDictionary *)indexOfObject:(NSInteger)index
{
    return self.arrayOfData[index];
}

#pragma mark - Work with plist methods

+ (void)addObject:(TMSTextAndImage *)object
{
    NSDictionary *newModel = @{@"stringName" : object.stringText,
                               @"stringPic" : object.stringPic};
    
    NSMutableArray *tempModelsArray = [NSMutableArray arrayWithContentsOfFile:[NSString pathToPlist]];
    [tempModelsArray addObject:newModel];
    
    if ([tempModelsArray writeToFile:[NSString pathToPlist] atomically:YES])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentDidChange object:nil];
        [TMSAlerts showAlertObjectAdded];
    }
    else
    {
        [TMSAlerts showAlertErrorAddingObjectToPlist];
    }
}

+ (void)copyDataPlistToDocumentFolder {
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error;
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *doumentDirectoryPath = [pathsArray objectAtIndex:0];
    
#warning имя файла надо вынести в константы
    NSString *destinationPath= [doumentDirectoryPath stringByAppendingPathComponent:@"TMSData.plist"];
    
    NSLog(@"plist path %@",destinationPath);
    if ([fileManger fileExistsAtPath:destinationPath])
    {
        return;
    }
    NSString *sourcePath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"TMSData.plist"];
    
    [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:&error];
}



@end
