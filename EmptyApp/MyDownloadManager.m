//
//  MyDownloadManager.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyDownloadManager.h"
#import "MyBoardHandler.h"
#import "MyPinHandler.h"
#import "MyUserInfo.h"
@implementation MyDownloadManager
+(instancetype)sharedInstance
{
    static MyDownloadManager* dm = nil;
    if(!dm)
    {
        dm=[[MyDownloadManager alloc]init];
    }
    return dm;
}
-(void)makeApiCall:(MyApiCallType)type completion:(void(^)(id data))completionBlock failure:(void(^)(long errorCode,NSError* errorObj))failBlock
{
    switch (type) {
        case kGetBoards:
        {
            MyBoardHandler* myBh = [[MyBoardHandler alloc]initWithUserName:[MyUserInfo userName]];
            [myBh downloadData:completionBlock failure:failBlock];
             break;
        }
           
        case kGetPins:
        {
            MyPinHandler* myPh = [[MyPinHandler alloc]initWithUserName:[MyUserInfo userName]];
            [myPh downloadData:completionBlock failure:failBlock];
            break;
        }
    }
}
@end
