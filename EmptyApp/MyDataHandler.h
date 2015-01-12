//
//  MyDataHandler.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyConstants.h"
@interface MyDataHandler : NSObject
@property (strong,nonatomic) NSString* userName;
-(instancetype)initWithUserName:(NSString*) userName;
-(void)downloadData:(void(^)(id data))completionBlock failure:(void(^)(long errorCode,NSError* errorObj))failBlock;
-(NSURL*)getCallPath;
-(id)processData:(NSData*) data error: (NSError**) error;
@end
