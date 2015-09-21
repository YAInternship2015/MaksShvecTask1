//
//  Constants.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/27/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Table_Maks_Shvec_Constants_h
#define Table_Maks_Shvec_Constants_h

#pragma mark - DataSource

static NSString *const kName = @"text";
static NSString *const kImageName = @"imageName";

#pragma mark - Notifications name

static NSString *const contentDidChange = @"ContenDidChange";

#pragma mark - DataSource plist

static NSString *const nameOfPlist = @"TMSData";
static NSString *const typeOfPlist = @".plist";
static NSString *const plistNameAndType = @"TMSData.plist";

#pragma mark - CoreData 

static NSString *const kNameOfCoreDatamodel = @"TMSCoreDataModel";
static NSString *const kNameOfEntity = @"TMSModelItem";

#endif
