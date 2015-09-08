//
//  TableViewCell.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#warning зачем здесь нужен следующий import?
#import "TMSTextAndImage.h"

@interface TMSTableViewCell : UITableViewCell

#warning ячейка должна заполняться моделью, а не NSDictionary
- (void)setupWithModel:(NSDictionary *)item;
 
@end
