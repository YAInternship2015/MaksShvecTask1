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
{
    TMSTableViewController *tableViewController;
    TMSCollectionViewController *collectionViewController;
    
    BOOL isTableViewController;
}

@end

@implementation TMSViewControllerWithSubview

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TMSTableViewController class])];
    collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TMSCollectionViewController class])];
    
    [self addChildViewController:tableViewController];
    [self addChildViewController:collectionViewController];
    
    [self.view addSubview:tableViewController.view];
    
}

#pragma mark - Actions

- (IBAction)changeViewButton:(id)sender
{
    UIViewAnimationOptions opt = 0;
    if (!isTableViewController) {
        opt = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        opt = UIViewAnimationOptionTransitionFlipFromRight;
    }
    [self transitionFromViewController:isTableViewController ? collectionViewController : tableViewController toViewController:isTableViewController ? tableViewController : collectionViewController duration:0.5 options:opt animations:nil completion:nil];
    
    isTableViewController = !isTableViewController;
}



@end
