//
//  TMSTextAndImage.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/15/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMSTextAndImage : NSObject

#warning не нужно в *.h файле показывать эти свойста с readwrite доступом. В *.h можно оставить readonly доступ, а в *.m - readwrite
#warning не самые "говорящие имена свойств". text и imageName будут лучше
@property (nonatomic, readwrite) NSString *stringText;
@property (nonatomic, readwrite) NSString *stringPic;

+ (TMSTextAndImage *)modelWithName: (NSString *)name;
 
@end
