//
//  TMSTextAndImage.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/15/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "TMSTextAndImage.h"

@interface TMSTextAndImage ()

@property (nonatomic, readwrite) NSString *text;
@property (nonatomic, readwrite) NSString *imageName;

@end

@implementation TMSTextAndImage

@synthesize text = _text;
@synthesize imageName = _imageName;


- (TMSTextAndImage *)initModelWithName: (NSString *)name
{
    if (self = [super init]) {
    _text = name;
    _imageName = @"noPic";
    }
    return self;
}


@end
 