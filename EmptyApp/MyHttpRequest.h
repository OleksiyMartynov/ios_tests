//
//  MyHttpHeaderCreator.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/7/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyConstants.h"
#import "MyHttpRequestDelegate.h"
@interface MyHttpRequest : NSObject
-(instancetype)initWithType:(MyRequestType)type URL:(NSURL*)url;
-(int)getHeaderFieldCount;
-(void)setHeaderField:(NSString*)name value:(NSString*)value;
-(void)sendRequestWithDelegate:(id<MyHttpRequestDelegate>) delegate;
-(void)sendRequestWithBlocks:(void(^)(NSData* data))completionBlock failure:(void(^)(long errorCode,NSError* errorObj))failureBlock;
@end
