//
//  TMSCollectionViewCell.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/28/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSCollectionViewCell.h"

@interface TMSCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *cellImage;

@end

@implementation TMSCollectionViewCell

- (void)setupWithModel:(NSDictionary *)item
{
    self.cellImage.image = [UIImage imageNamed:item[@"imageName"]];
    self.cellImage.contentMode = UIViewContentModeScaleAspectFit;
}


@end
