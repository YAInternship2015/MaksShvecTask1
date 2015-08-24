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
    if (self) {
        NSBundle *thisApp = [NSBundle mainBundle];
        NSString *pathToCatsData = [thisApp pathForResource:fileName ofType:fileType];
        if ([self loadDataFromFile:pathToData] == NO) {
            NSLog(@"couldn't find data in '%@' file",pathToData);
            return nil;
        }
    }
    return self;
}

- (BOOL)loadDataFromFile:(NSString *)pathToData {
    NSArray *rawData = [NSArray arrayWithContentsOfFile:pathToData];
    if (rawData) {
        self.arrayOfData = [NSMutableArray array];
        for (NSDictionary *cat in rawData) {
            TMSTextAndImage *oneCatData = [[TMSTextAndImage alloc] initWithDictionary:cat];
            [self.arrayOfData addObject:oneCatData];
        }
        return YES;
    }
    return NO;
}
@end
