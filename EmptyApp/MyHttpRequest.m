//
//  MyHttpHeaderCreator.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/7/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyHttpRequest.h"
@interface MyHttpRequest()
@property (strong, nonatomic)NSMutableDictionary* headerFields;
@property (strong, nonatomic)id<MyHttpRequestDelegate> delegate;
@property (assign, nonatomic)MyRequestType type;
@property (strong, nonatomic)NSURL* url;

@end
@implementation MyHttpRequest
-(instancetype)initWithType:(MyRequestType)type URL:(NSURL*)url
{
    if((self=[super init]))
    {
        self.headerFields= [[NSMutableDictionary alloc]init];
        self.type=type;
        self.url=url;
    }
    return self;
}
-(int)getHeaderFieldCount
{
    return self.headerFields.count;
}
-(void)setHeaderField:(NSString*)name value:(NSString*)value
{
    [self.headerFields setObject:value forKey:name];
}
-(void)setOnConnectionCompleteDelegate:(id<MyHttpRequestDelegate>) delegate
{
    self.delegate=delegate;
}
-(NSData*)sendRequest:(NSError**) error resp: (NSURLResponse**) responce
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    switch (self.type) {
        case kGet:
            [request setHTTPMethod:@"GET"];
            break;
        case kPost:
            [request setHTTPMethod:@"POST"];
            break;
        default:
        {
            NSMutableDictionary* details = [[NSMutableDictionary alloc]init];
            [details setValue:@"Unknown request type." forKey:NSLocalizedDescriptionKey];
            *error = [NSError errorWithDomain:@"http request" code:200 userInfo:details];
             break;
        }
    }
    
    //[request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
   
    for(id key in self.headerFields)
    {
        NSString* value = [self.headerFields objectForKey:key];
        [request addValue:value forHTTPHeaderField:key];
    }
     NSLog(@"hf:%@",request.allHTTPHeaderFields);
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:responce error:error];
    NSString* htmlResponce = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",htmlResponce);
    return data;
}
-(void)sendRequestWithDelegate:(id<MyHttpRequestDelegate>) delegate
{
    if(delegate){
        [delegate onRequestSent];
    }
    
    NSURLResponse* responce=nil;
    NSError* error=nil;
    NSData* data = [self sendRequest:&error resp:&responce];
    long statusCode =[(NSHTTPURLResponse*)responce statusCode];
    NSLog(@"status code:%li",statusCode);
    if(error==nil){
       if(delegate)
       {
           [delegate onRequestComplete:data];
       }
    }else{
        if(delegate)
        {
            [delegate onRequestError:statusCode errorObj:error];
        }
    }
}
-(void)sendRequestWithBlocks:(void(^)(NSData* data))completionBlock failure:(void(^)(long errorCode,NSError* errorObj))failureBlock
{
    NSURLResponse* responce=nil;
    NSError* error=nil;
    NSData* data = [self sendRequest:&error resp:&responce];
    long statusCode =[(NSHTTPURLResponse*)responce statusCode];
    NSLog(@"status code:%li",statusCode);
    if(error==nil){
        if(completionBlock)
        {
            completionBlock(data);
        }
    }else{
        if(failureBlock)
        {
            failureBlock(statusCode,error);
        }
    }
}
@end
