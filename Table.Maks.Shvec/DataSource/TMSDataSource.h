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

@protocol TMSDataSourceDelegate;

@interface TMSDataSource : NSObject

@property (nonatomic, weak) id<TMSDataSourceDelegate>delegate;

- (instancetype)initWithDelegate:(id<TMSDataSourceDelegate>)delegate;

- (void)addModelWithImageKey:(NSString *)imageKey nameKey:(NSString *)nameKey;
- (void)deleteModelAtIndex:(NSIndexPath *)index;
- (TMSModelItem*)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)modelsCount;
- (NSInteger)numberObjectsInSection: (NSInteger)section;
- (void)saveContext;

+ (void)copyDataPlistToDocumentFolder;

@end

@protocol TMSDataSourceDelegate <NSObject>

@optional

- (void)addModelWithImageKey:(NSString *)imageKey nameKey:(NSString *)nameKey;

//- (void)contentWasChangedAtIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath;
- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller;

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller;


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:( NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath;

//- (void)controller:(NSFetchedResultsController *)controller
//  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex
//     forChangeType:(NSFetchedResultsChangeType)type;

@end

