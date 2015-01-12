//
//  MyPinHandler.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyPinHandler.h"
static NSString * const kPinsPathPart = @"pins";
@implementation MyPinHandler

-(id)processData:(NSData*) data error: (NSError**) error
{
    NSMutableDictionary *dJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
    //todo save dictionary as object to coredata
    return dJSON;
}
-(NSURL*)getCallPath
{
    NSString* urlStr = [NSString stringWithFormat:@"%@%@/%@",kPinterestApiAddress,self.userName,kPinsPathPart ];
    NSLog(@"url:%@",urlStr);
    return [NSURL URLWithString:urlStr];
}
@end
