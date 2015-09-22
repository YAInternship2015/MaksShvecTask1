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

- (void)addModelWithImageKey: (NSString*)imageKey nameKey:(NSString*)nameKey;
- (void)deleteModelWithIndex:(NSIndexPath *)index;
- (TMSModelItem*)modelWithIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)modelsCount;

+ (void)copyDataPlistToDocumentFolder;

@end

@protocol TMSDataSourceDelegate <NSObject>

@optional

- (void)addModelWithDelegateImageKey: (NSString*)imageKey nameKey:(NSString*)nameKey;

- (void)contentWasChangedAtIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath;

@end

