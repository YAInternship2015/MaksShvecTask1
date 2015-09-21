//
//  TMSCollectionViewCell.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/28/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMSModelItem.h"

@interface TMSCollectionViewCell : UICollectionViewCell

- (void)setupWithModel:(TMSModelItem *)model;

@end
