//
//  TableViewController.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSTableViewController.h"
#import "TMSTextAndImage.h"
#import "TMSDataSource.h"

@interface TMSTableViewController ()
{
//    NSMutableArray *arrayObjects;
}
@property (nonatomic, strong) TMSDataSource *textAndImageDataSource;

@end

@implementation TMSTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    self.textAndImageDataSource = [[TMSDataSource alloc]initFromPlist];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.textAndImageDataSource.arrayOfData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    
    [cell setupWithModel:[[self.textAndImageDataSource loadPlist] objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
