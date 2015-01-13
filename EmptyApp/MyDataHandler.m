//
//  MyDataHandler.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyDataHandler.h"
#import "MyHttpRequest.h"
@interface MyDataHandler()
@end
@implementation MyDataHandler
-(instancetype)initWithUserName:(NSString*) userName
{
    if((self=[super init]))
    {
        self.userName = userName;
    }
    return self;
}
-(void)downloadData:(void(^)(id data))completionBlock failure:(void(^)(long errorCode,NSError* errorObj))failBlock
{
    MyHttpRequest* request = [[MyHttpRequest alloc]initWithType:kGet URL:[self getCallPath]];
    [request setHeaderField:kPinterestApiKey value:kPinterestApiValue];
    void(^parsedCompletion)(id )=^void(id data){
        NSError* error;
        NSLog(@"blah!->%@",data);
        id outData = [self processData:data error:&error];
        if(error){
            NSMutableDictionary* details = [[NSMutableDictionary alloc]init];
            [details setValue:@"Could not parse json." forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"http result" code:200 userInfo:details];
            failBlock(200,error);
        }
        else{
            completionBlock(outData);
        }
    };
    [request sendRequestWithBlocks:parsedCompletion failure:failBlock];
}
-(NSURL*)getCallPath
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}
-(id)processData:(NSData*) data error: (NSError**) error
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}
@end
