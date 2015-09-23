//
//  TableViewController.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSTableViewController.h"
#import "TMSDataSource.h"
#import "TMSTableViewCell.h"
#import "TMSAlertsFactory.h"

@interface TMSTableViewController ()<TMSDataSourceDelegate>

@property (nonatomic, strong) TMSDataSource *dataSource;

@end

@implementation TMSTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [[TMSDataSource alloc] initWithDelegate:self];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource modelsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    [cell setupWithModel:[self.dataSource modelAtIndexPath:indexPath]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        [self.dataSource deleteModelAtIndex:indexPath];
        [self.tableView endUpdates];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - TMSDataSourceDelegate

- (void)contentWasChangedAtIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView beginUpdates];
    
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [self.tableView reloadData];
    }
    
    [self.tableView endUpdates];
}


@end
