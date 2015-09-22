//
//  TMSCollectionViewController.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/20/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSCollectionViewController.h"
#import "TMSDataSource.h"
#import "TMSCollectionViewCell.h"

@interface TMSCollectionViewController ()<NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) TMSDataSource* dataSource;
@property (nonatomic, strong) NSMutableArray* arrayOfChanges;

@end

@implementation TMSCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.dataSource = [[TMSDataSource alloc]initWithDelegate:self];
    self.collectionView.alwaysBounceVertical = YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource modelsCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
    [cell setupWithModel:[self.dataSource modelWithIndexPath:indexPath]];
    
    return cell;
}

#pragma mark - Methods

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    CGPoint locationPoint = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:locationPoint];
    if (sender.state == UIGestureRecognizerStateBegan && indexPath) {
        [self.dataSource deleteModelWithIndex:indexPath];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.arrayOfChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            break;
    }
    [self.arrayOfChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView performBatchUpdates:^{
        
        for (NSDictionary *change in self.arrayOfChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        break;
                    case NSFetchedResultsChangeMove:
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        self.arrayOfChanges = nil;
    }];
}

@end

