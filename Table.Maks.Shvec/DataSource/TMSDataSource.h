//
//  TMSDataSource.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMSTextAndImage.h"

@interface TMSDataSource : NSObject

@property (nonatomic, strong) NSMutableArray *arrayOfData;

- (instancetype)initFromFile:(NSString *)fileName ofType: (NSString *)fileType;

- (BOOL)loadDataFromFile:(NSString *)pathToData;

- (NSUInteger)numberOfObjects;

- (TMSTextAndImage *)objectAtIndex: (NSUInteger)indexOfObject;

- (NSDictionary *)loadPlist;

@end
