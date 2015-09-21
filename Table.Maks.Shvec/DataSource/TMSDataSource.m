//
//  TMSDataSource.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSDataSource.h"
#import "NSString+Path.h"

@interface TMSDataSource ()

@property (nonatomic, strong) NSArray *arrayOfData;

@property (nonatomic, strong) NSManagedObjectModel* managedModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, weak) id<NSFetchedResultsControllerDelegate>fetchedDelegate;

@end

@implementation TMSDataSource

#pragma mark - DataSource init methods

- (instancetype)initWithDelegate: (id<NSFetchedResultsControllerDelegate>)delegate {
    self = [self init];
    if (self)
    {
        self.fetchedDelegate = delegate;
    }
    return self;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSManagedObjectContext* context = self.managedObjectContext;
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description = [NSEntityDescription entityForName: kNameOfEntity
                                                   inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kName ascending:YES];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest
                                     managedObjectContext:context
                                     sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self.fetchedDelegate;
    
    return _fetchedResultsController;
}

#pragma mark - DataSource methods

- (void)addModelWithImageKey: (NSString*)imageKey nameKey:(NSString*)nameKey
{
    NSManagedObjectContext* context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entityDescription = [[self.fetchedResultsController fetchRequest]entity];
    NSManagedObject* newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entityDescription name] inManagedObjectContext:context];
    
    [newManagedObject setValue:imageKey forKey:kImageName];
    [newManagedObject setValue:nameKey forKey:kName];

    NSError* error = nil;
    if (![context save:&error]) {
        NSLog(@"Error in saving %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)deleteModelWithIndex:(NSIndexPath *)index {
    NSManagedObjectContext* context = [self.fetchedResultsController managedObjectContext];
    [context deleteObject:[self.fetchedResultsController objectAtIndexPath:index]];
    
    NSError* error = nil;
    if (![context save:&error]) {
        NSLog(@"Error in saving %@, %@", error, [error userInfo]);
        abort();
    }
}

- (TMSModelItem*)modelWithIndexPath:(NSIndexPath *)indexPath {
    TMSModelItem *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return model;
}

- (NSInteger)moviesCount {
    self.fetchedResultsController;
}

#pragma mark - Old methods for plist
/*
- (void)loadDataArrayWithPlist {
    self.arrayOfData = [NSArray arrayWithContentsOfFile:[NSString pathToPlist]];
//    [self.delegate dataWasChanged:self];
}

- (void)reloadDataArrayWithPlist {
    [self loadDataArrayWithPlist];
}

- (NSUInteger)numberOfObjects {
    return [self.arrayOfData count];
}

- (TMSTextAndImage *)indexOfObject:(NSInteger)index {
    TMSTextAndImage *model = [[TMSTextAndImage alloc]init];
    NSMutableDictionary *dictModel = (NSMutableDictionary *)[self.arrayOfData objectAtIndex:index];
//    model.text = [dictModel objectForKey:@"text"];
//    model.imageName = [dictModel objectForKey:@"imageName"];
    return model;
}

+ (void)addObject:(TMSTextAndImage *)object {
    NSDictionary *newModel = @{@"text" : object.text,
                               @"imageName" : object.imageName};
    
    NSMutableArray *tempModelsArray = [NSMutableArray arrayWithContentsOfFile:[NSString pathToPlist]];
    [tempModelsArray addObject:newModel];
    
    if ([tempModelsArray writeToFile:[NSString pathToPlist] atomically:YES])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:contentDidChange object:nil];
    }
}
*/
#pragma mark - Work with plist methods

+ (void)copyDataPlistToDocumentFolder {
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error;
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *doumentDirectoryPath = [pathsArray objectAtIndex:0];
    
    NSString *destinationPath= [doumentDirectoryPath stringByAppendingPathComponent:plistNameAndType];
    
    NSLog(@"plist path %@",destinationPath);
    if ([fileManger fileExistsAtPath:destinationPath])
    {
        return;
    }
    NSString *sourcePath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:plistNameAndType];
    
    [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:&error];
}

#pragma mark - CoreData getters

- (NSManagedObjectContext *)defaultContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedModel];
        
        NSURL* pathToDocumentFolder =  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL* pathToSqliteFile = [pathToDocumentFolder URLByAppendingPathComponent:@"TMSCoreDataModel.sqlite"];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:pathToSqliteFile
                                                        options:nil
                                                          error:NULL];
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedModel {
    if (!_managedModel) {
        NSURL* pathToXCModel = [[NSBundle mainBundle] URLForResource:kNameOfCoreDatamodel withExtension:@"momd"];
        _managedModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:pathToXCModel];
    }
    
    return _managedModel;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
