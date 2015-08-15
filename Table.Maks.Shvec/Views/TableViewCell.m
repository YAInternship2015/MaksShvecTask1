//
//  TableViewCell.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell () {
    IBOutlet UIImageView *pic;
    IBOutlet UILabel *someLabel;
}
 
@end

@implementation TableViewCell

- (void)setupWithModel:(TMSTextAndImage *)object {
    [pic setImage:[UIImage imageNamed:object.stringText]];
    pic.contentMode = UIViewContentModeScaleAspectFit;
    
    someLabel.text = object.stringText;
}

@end
