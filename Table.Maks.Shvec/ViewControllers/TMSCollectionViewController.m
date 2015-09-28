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

@interface TMSCollectionViewController ()<TMSDataSourceDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) TMSDataSource *dataSource;

@end

@implementation TMSCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [[TMSDataSource alloc] initWithDelegate:self];
    self.collectionView.alwaysBounceVertical = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.dataSource reloadByDataSource];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource modelsCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TMSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
    [cell setupWithModel:[self.dataSource modelAtIndexPath:indexPath]];
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat mainScreen = CGRectGetWidth([UIScreen mainScreen].bounds);
#warning TODO: constants 1 & 5
    CGFloat cellSize = (mainScreen / kPreferesCellSize < kQuantityOfCellsInRow) ? (mainScreen - kCellSpacing) / (kQuantityOfCellsInRow -1) : (mainScreen - kCellSpacing-5) / kQuantityOfCellsInRow;
    return CGSizeMake(cellSize, cellSize);
}

#pragma mark - Methods

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [sender locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:kDurationAnimationForDeletingElement animations:^{
            UICollectionViewCell *cell = [weakSelf.collectionView cellForItemAtIndexPath:indexPath];
            cell.layer.transform = CATransform3DMakeRotation(M_PI,1.0,0.0,0.0);;
        } completion:^(BOOL finished) {
            [weakSelf.collectionView performBatchUpdates:^{
#warning TODO fix deleting
                [weakSelf.dataSource deleteModelAtIndex:indexPath];
            } completion:nil];
        }];
    }
}

#pragma mark - TMSDataSource methods

- (void)contentWasChangedAtIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (type == NSFetchedResultsChangeInsert) {
        [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } else {
        [self.collectionView reloadData];
    }
}

@end

