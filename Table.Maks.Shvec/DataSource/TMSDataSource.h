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

@property (nonatomic, strong) NSMutableArray *arrayOfData;

@property (nonatomic, weak) id<TMSDataSourceDelegate>delegate;

- (instancetype)initWithDelegate: (id<TMSDataSourceDelegate>)delegate;

- (TMSDataSource *)initFromPlist;

- (BOOL)loadDataFromFile:(NSString *)pathToData;

- (NSUInteger)numberOfObjects;

//- (TMSTextAndImage *)objectAtIndex: (NSUInteger)indexOfObject;

//- (NSMutableArray *)loadPlist;

+ (void)copyDataPlistToDocumentFolder;

+ (void)addObject:(TMSTextAndImage *)object;

@end

@protocol TMSDataSourceDelegate <NSObject>

@required

- (void)dataWasChanged:(TMSDataSource *)dataSource;

@end
