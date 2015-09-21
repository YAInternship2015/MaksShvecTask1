//
//  TMSDataSource.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TMSModelItem.h"

@interface TMSDataSource : NSObject

- (instancetype)initWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
/*
- (void)loadDataArrayWithPlist;
- (NSUInteger)numberOfObjects;
- (TMSTextAndImage *)indexOfObject:(NSInteger)index;
+ (void)addObject:(TMSTextAndImage *)object;
*/
- (void)addModelWithImageKey: (NSString*)imageKey nameKey:(NSString*)nameKey;

- (void)deleteModelWithIndex:(NSIndexPath *)index;

- (TMSModelItem*)modelWithIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)modelsCount;

+ (void)copyDataPlistToDocumentFolder;

@end
