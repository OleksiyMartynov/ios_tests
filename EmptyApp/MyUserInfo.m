//
//  MyUserInfo.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyUserInfo.h"

@implementation MyUserInfo
static NSString* un=nil;
+(NSString*)userName
{
    if(!un)
    {
        //can be loaded from storage
    }
    return un;
}
+(void)setUserName:(NSString*)name
{
    un=name;
}
@end
