//
//  MyDataManager.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/12/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//



#import "MyDataManager.h"
#import "TestEntity.h"
//#import <dispatch/dispatch.h>


dispatch_queue_t background_save_queue(void);

 static dispatch_queue_t coredata_background_save_queue;

dispatch_queue_t background_save_queue()
{
    if (coredata_background_save_queue == NULL)
    {
        coredata_background_save_queue = dispatch_queue_create("com.magicalpanda.magicalrecord.backgroundsaves", 0);
    }
    return coredata_background_save_queue;
}


@interface MyDataManager()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end
@implementation MyDataManager

+(instancetype)sharedInstance
{
    static MyDataManager* instance =nil;
    if(!instance)
    {
        instance = [[MyDataManager alloc]init];
    }
    return instance;
}
-(instancetype)init
{
    if((self=[super init]))
    {
        
    }
    return self;
}
-(void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion errorBlock: (void(^)(NSError* error))errorBlock
{
    dispatch_async(background_save_queue(), ^{
        NSError* error = nil;
		[self saveDataInContext:saveBlock error:&error];
        
		dispatch_sync(dispatch_get_main_queue(), ^{
			if(error){
                errorBlock(error);
            }
            else{
                completion();
            }
		});
        
	});
}
-(void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion
{
    dispatch_async(background_save_queue(), ^{
		[self saveDataInContext:saveBlock];
        
		dispatch_sync(dispatch_get_main_queue(), ^{
			completion();
		});
	});
}
-(void)saveDataInContext:(void(^)(NSManagedObjectContext *context))saveBlock
{
    saveBlock(self.managedObjectContext);
    NSError* error=nil;
    if([self.managedObjectContext hasChanges])
    {
        [self.managedObjectContext save:&error];
    }
}
-(void)saveDataInContext:(void(^)(NSManagedObjectContext *context))saveBlock error:(NSError**) error
{
    saveBlock(self.managedObjectContext);
    if([self.managedObjectContext hasChanges])
    {
        [self.managedObjectContext save:error];
    }
}
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Core_Data.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}



// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
