//
//  TMSViewControllerWithSubview.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/20/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSViewControllerWithSubview.h"
#import "TMSTableViewController.h"
#import "TMSCollectionViewController.h"
#import "TMSViewControllerWithAddFunc.h"

@interface TMSViewControllerWithSubview ()

@property (nonatomic, strong)TMSTableViewController *tableViewController;
@property (nonatomic, strong)TMSCollectionViewController *collectionViewController;
@property (nonatomic, assign)BOOL isTableViewController;

@end

@implementation TMSViewControllerWithSubview

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TMSTableViewController class])];
    self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TMSCollectionViewController class])];
    
    [self addChildViewController:self.tableViewController];
    [self addChildViewController:self.collectionViewController];
    
    [self.view addSubview:self.tableViewController.view];
    
}

#pragma mark - Actions

- (IBAction)changeViewButton:(id)sender {
        UIViewAnimationOptions opt = 0;
    if (!self.isTableViewController) {
        opt = UIViewAnimationOptionTransitionFlipFromLeft;}
    else {
        opt = UIViewAnimationOptionTransitionFlipFromRight;
    }
    
    
    [self transitionFromViewController:self.isTableViewController ? self.collectionViewController : self.tableViewController toViewController:self.isTableViewController ? self.tableViewController : self.collectionViewController duration:kDurationAnimation options:opt animations:nil completion:nil];
    
    self.isTableViewController = !self.isTableViewController;
}


@end
