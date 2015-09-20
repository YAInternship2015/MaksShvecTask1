//
//  TableViewCell.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMSTextAndImage+DictionaryRepresentation.h"

@interface TMSTableViewCell : UITableViewCell

#warning ячейка должна заполняться моделью, а не NSDictionary
- (void)setupWithModel:(TMSTextAndImage *)model;
 
@end
