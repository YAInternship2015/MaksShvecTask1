//
//  TMSDataSource.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSDataSource.h"
#import "NSString+Path.h"
#import "TMSModelItem.h"

@interface TMSDataSource ()

@property (nonatomic, strong) NSArray *arrayOfData;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

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
    /*
    if ([self modelsCount] == 0) {
        NSMutableArray* arr = [[NSArray arrayWithContentsOfFile:[NSString pathToPlist]] mutableCopy];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary * model = arr[i];
            NSString* name = [model valueForKey:kName];
            NSString* image = [model valueForKey:kImageName];
            [self addModelWithImageKey:name nameKey:image];
        }
     */
    return self;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSManagedObjectContext* context = self.managedObjectContext;
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"TMSModelItem"
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


- (NSInteger)modelsCount {
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
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

#pragma mark - CoreData stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kNameOfCoreDatamodel withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TMSCoreDataModel.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {

        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {

    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}
#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
