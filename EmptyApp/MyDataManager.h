//
//  MyDataManager.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/12/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataManager : NSObject
+(instancetype)sharedInstance;
-(instancetype)init;
- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
-(void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion errorBlock: (void(^)(NSError* error))errorBlock;
-(void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion;
-(void)saveDataInContext:(void(^)(NSManagedObjectContext *context))saveBlock error:(NSError**) error;
-(void)saveDataInContext:(void(^)(NSManagedObjectContext *context))saveBlock;
@end
