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

@property (nonatomic, weak) id<TMSDataSourceDelegate>delegate;

- (instancetype)initWithDelegate: (id<TMSDataSourceDelegate>)delegate;

//- (TMSDataSource *)initFromPlist;

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
