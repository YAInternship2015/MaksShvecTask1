//
//  TMSCollectionViewCell.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/28/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMSCollectionViewCell : UICollectionViewCell

#warning ячейка должна заполняться моделью, а не NSDictionary
- (void)setupWithModel:(NSDictionary *)item;

@end
