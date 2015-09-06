//
//  TMSCollectionViewController.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/20/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSCollectionViewController.h"
#import "TMSDataSource.h"

@interface TMSCollectionViewController ()<TMSDataSourceDelegate>

@property (nonatomic, strong) TMSDataSource *dataSource;

@end

@implementation TMSCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [[TMSDataSource alloc]initWithDelegate:self];
    self.collectionView.alwaysBounceVertical = YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCollectionCell" forIndexPath:indexPath];
    
    [cell setupWithModel:[self.dataSource indexOfObject:indexPath.row]];
    
    return cell;
}

# pragma mark - TMSDataSourceDelegate methods

- (void)dataWasChanged:(TMSDataSource *)dataSource
{
    [self.collectionView reloadData];
}


@end
