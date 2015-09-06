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

@property (nonatomic, strong) TMSDataSource *textAndImageDataSource;

@end

@implementation TMSCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textAndImageDataSource = [[TMSDataSource alloc]initFromPlist];
    self.collectionView.alwaysBounceVertical = YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.textAndImageDataSource.arrayOfData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCollectionCell" forIndexPath:indexPath];
    
    [cell setupWithModel:[self.textAndImageDataSource.arrayOfData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)dataWasChanged:(TMSDataSource *)dataSource
{
    [self.collectionView reloadData];
}


@end
