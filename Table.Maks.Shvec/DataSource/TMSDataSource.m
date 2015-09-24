//
//  TMSDataSource.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/16/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TMSDataSource.h"
#import "NSString+Path.h"

@interface TMSDataSource ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end

@implementation TMSDataSource

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - DataSource methods

- (instancetype)initWithDelegate: (id<TMSDataSourceDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    //loading from plist
    if ([self modelsCount] == 0) {
        NSMutableArray* arr = [[NSArray arrayWithContentsOfFile:[NSString pathToPlist]] mutableCopy];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary * model = arr[i];
            NSString* name = [model valueForKey:kName];
            NSString* image = [model valueForKey:kImageName];
            [self addModelWithImageKey:name nameKey:image];
        }
    }
    }
    return self;
}

- (void)addModelWithDelegateImageKey: (NSString*)imageKey nameKey:(NSString*)nameKey
{
    NSManagedObjectContext* context = [self.fetchedResultsController managedObjectContext];
    NSString * entityClassName = NSStringFromClass([TMSModelItem class]);
    TMSModelItem *newObject = [NSEntityDescription insertNewObjectForEntityForName:entityClassName inManagedObjectContext:context];
    
    [newObject setValue:imageKey forKey:kImageName];
    [newObject setValue:nameKey forKey:kName];
    
    NSError* error = nil;
    if (![context save:&error]) {
        NSLog(@"Error in saving %@, %@", error, [error userInfo]);
        abort();
    }
}

//- (void)contentWasChangedAtIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
//    [self.delegate contentWasChangedAtIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
//}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    [self.delegate controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate controllerWillChangeContent:controller];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate controllerDidChangeContent: controller];
}


- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSManagedObjectContext* context = self.managedObjectContext;
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kNameOfEntity];
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kName ascending:YES];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest
                                     managedObjectContext:context
                                     sectionNameKeyPath:nil cacheName:@"MyCache"];
    
    NSError* error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    return _fetchedResultsController;
}

#pragma mark - DataSource methods

- (void)addModelWithImageKey: (NSString*)imageKey nameKey:(NSString*)nameKey
{
    NSManagedObjectContext* context = [self.fetchedResultsController managedObjectContext];
    NSString * entityClassName = NSStringFromClass([TMSModelItem class]);
    TMSModelItem *newObject = [NSEntityDescription insertNewObjectForEntityForName:entityClassName inManagedObjectContext:context];
    
    [newObject setValue:imageKey forKey:kImageName];
    [newObject setValue:nameKey forKey:kName];

    NSError* error = nil;
    if (![context save:&error]) {
        NSLog(@"Error in saving %@, %@", error, [error userInfo]);
        abort();
    }
}


- (void)deleteModelAtIndex:(NSIndexPath *)index {
    NSManagedObjectContext* context = [self.fetchedResultsController managedObjectContext];
    [context deleteObject:[self.fetchedResultsController objectAtIndexPath:index]];
    
    NSError* error = nil;
    if (![context save:&error]) {
        NSLog(@"Error in saving %@, %@", error, [error userInfo]);
        abort();
    }
    [self saveContext];
}

- (TMSModelItem*)modelAtIndexPath:(NSIndexPath *)indexPath {
    TMSModelItem *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"------Model description------ %@", [model description]);
    return model;
}

- (NSInteger)numberObjectsInSection: (NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (NSInteger)modelsCount {
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

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
