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
        NSBundle *thisApp = [NSBundle mainBundle];
        NSString *pathToData = [thisApp pathForResource:fileName ofType:fileType];
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
@end
