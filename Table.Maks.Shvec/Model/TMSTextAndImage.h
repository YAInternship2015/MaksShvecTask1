//
//  TMSTextAndImage.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/15/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMSTextAndImage : NSObject

@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) NSString *imageName;


- (TMSTextAndImage *)initModelWithName: (NSString *)name;
 
@end
