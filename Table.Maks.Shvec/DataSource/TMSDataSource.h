//
//  TMSDataSource.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMSTextAndImage.h"

@protocol TMSDataSourceDelegate;


@interface TMSDataSource : NSObject

#warning это свойство должно быть в *.m. И из следующих методов в *.h должны остаться только те, которые вызываются извне. Остальные нужно удалить из *.h
@property (nonatomic, weak) id<TMSDataSourceDelegate>delegate;

- (instancetype)initWithDelegate: (id<TMSDataSourceDelegate>)delegate;

- (void)loadDataArrayWithPlist;

- (void)reloadDataArrayWithPlist;

- (NSUInteger)numberOfObjects;

- (NSDictionary *)indexOfObject:(NSInteger)index;


+ (void)copyDataPlistToDocumentFolder;

+ (void)addObject:(TMSTextAndImage *)object;

@end


@protocol TMSDataSourceDelegate <NSObject>

@required

- (void)dataWasChanged:(TMSDataSource *)dataSource;

@end
