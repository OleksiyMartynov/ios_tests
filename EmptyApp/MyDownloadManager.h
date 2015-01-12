//
//  MyDownloadManager.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyConstants.h"
@interface MyDownloadManager : NSObject
+(instancetype)sharedInstance;
-(void)makeApiCall:(MyApiCallType)type completion:(void(^)(id data))completionBlock failure:(void(^)(long errorCode,NSError* errorObj))failBlock;
@end
