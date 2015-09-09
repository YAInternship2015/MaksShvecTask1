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

@interface TMSTableViewController ()<TMSDataSourceDelegate>
{

}
@property (nonatomic, strong) TMSDataSource *dataSource;

@end

@implementation TMSTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#warning высоту ячейки можно задать в сториборде у UITableView
    self.tableView.rowHeight = 80;
    self.dataSource = [[TMSDataSource alloc]initWithDelegate:self];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
#warning идентификатор ячейки можно объявить константой в самой ячейке
    TMSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    
    [cell setupWithModel:[self.dataSource indexOfObject:indexPath.row]];
    
    return cell;
}

#pragma mark - TMSDataSourceDelegate methods

- (void)dataWasChanged:(TMSDataSource *)dataSource
{
    [self.tableView reloadData];
}

@end
