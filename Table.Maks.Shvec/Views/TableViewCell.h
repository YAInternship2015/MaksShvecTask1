//
//  TableViewCell.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMSTextAndImage.h"

@interface TableViewCell : UITableViewCell

- (void)setupWithModel:(TMSTextAndImage *)object;

@end
