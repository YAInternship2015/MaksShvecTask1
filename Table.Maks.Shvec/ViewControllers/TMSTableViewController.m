//
//  TableViewController.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSTableViewController.h"
#import "TMSTextAndImage.h"

@interface TMSTableViewController ()
{
    NSMutableArray *arrayObjects;
} 

@end

@implementation TMSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    arrayObjects = [NSMutableArray new];
    for (int i = 1; i<=10; i++)
    {
        TMSTextAndImage *object = [TMSTextAndImage new];
        object.stringText = [NSString stringWithFormat:@"%i", i];
        [arrayObjects addObject:object];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arrayObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    
    [cell setupWithModel:arrayObjects[indexPath.row]];
    
    return cell;
}

@end
