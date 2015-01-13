//
//  Board.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/12/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pin;

@interface Board : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * href;
@property (nonatomic, retain) NSString * src;
@property (nonatomic, retain) NSSet *pins;
@end

@interface Board (CoreDataGeneratedAccessors)

- (void)addPinsObject:(Pin *)value;
- (void)removePinsObject:(Pin *)value;
- (void)addPins:(NSSet *)values;
- (void)removePins:(NSSet *)values;

@end
