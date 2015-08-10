//
//  TableViewCell.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

#warning эти свойства нет необходимости показывать в *.h файле. Если вы реализуете метод setupWithModel:, то эти свойства переедут в *.m файл. Не нужно показывать в *.h файле ничего лишнего, только то, что необходимо для работы других объектов с данным классом
@property (nonatomic, strong) IBOutlet UIImageView *pic;
@property (nonatomic, strong) IBOutlet UILabel *someLabel;

@end
