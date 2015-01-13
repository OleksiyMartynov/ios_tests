//
//  Pin.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/12/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Board;

@interface Pin : NSManagedObject

@property (nonatomic, retain) NSString * href;
@property (nonatomic, retain) NSString * src;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * attrib;
@property (nonatomic, retain) NSSet *boards;
@end

@interface Pin (CoreDataGeneratedAccessors)

- (void)addBoardsObject:(Board *)value;
- (void)removeBoardsObject:(Board *)value;
- (void)addBoards:(NSSet *)values;
- (void)removeBoards:(NSSet *)values;

@end
