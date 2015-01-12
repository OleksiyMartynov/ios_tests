//
//  MyBoardHandler.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyBoardHandler.h"
#import "MyHttpRequest.h"
static NSString * const kBoardPathPart = @"boards";
@implementation MyBoardHandler

-(id)processData:(NSData*) data error: (NSError**) error
{
    NSMutableDictionary *dJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
    //todo save dictionary as object to coredata
    return dJSON;
}
-(NSURL*)getCallPath
{
    NSString* urlStr = [NSString stringWithFormat:@"%@%@/%@",kPinterestApiAddress,self.userName,kBoardPathPart ];
    NSLog(@"url:%@",urlStr);
    return [NSURL URLWithString:urlStr];
}
@end
