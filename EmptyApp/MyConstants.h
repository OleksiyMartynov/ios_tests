//
//  MyConstants.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/7/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyConstants : NSObject
typedef enum{
    kGet=0,
    kPost
}MyRequestType;
typedef enum{
    kGetBoards=0,
    kGetPins
}MyApiCallType;
extern NSString *const kPinterestApiAddress;
extern NSString *const kPinterestApiKey;
extern NSString *const kPinterestApiValue;
@end
