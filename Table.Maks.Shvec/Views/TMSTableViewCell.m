//
//  TableViewCell.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSTableViewCell.h"
#import "TMSDataSource.h"

@interface TMSTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *cellPic;
@property (nonatomic, weak) IBOutlet UILabel *cellText;
 
@end

@implementation TMSTableViewCell

- (void)setupWithModel:(TMSModelItem *)model
{
    self.cellText.text = model.text;
    self.cellPic.image = [UIImage imageNamed: model.nameImage];
#warning contentMode лучше задать в сториборде
    self.cellPic.contentMode = UIViewContentModeScaleAspectFit;
}


@end
