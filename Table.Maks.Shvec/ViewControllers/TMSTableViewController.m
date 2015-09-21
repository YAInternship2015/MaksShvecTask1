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

@interface TMSTableViewController ()<NSFetchedResultsControllerDelegate>
{

}
@property (nonatomic, strong) TMSDataSource *dataSource;

@end

@implementation TMSTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [[TMSDataSource alloc]initWithDelegate:self];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource modelsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    [cell setupWithModel:[self.dataSource modelWithIndexPath:indexPath]];
    
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            break;
        default:
            UIAlertController *alert = [TMSAlertsFactory showAlertWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Error", nil)] message:[error localizedDescription]];
            
            [self presentViewController:alert animated:YES completion:nil];
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
