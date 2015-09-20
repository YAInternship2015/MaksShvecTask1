//
//  TMSModelItem.h
//  Table.Maks.Shvec
//
//  Created by Maks on 9/20/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TMSModelItem : NSManagedObject

@property (nonatomic, retain) NSString * nameImage;
@property (nonatomic, retain) NSString * text;

@end
