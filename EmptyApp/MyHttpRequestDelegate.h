//
//  MyHttpRequestListener.h
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/7/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyHttpRequestDelegate <NSObject>
-(void)onRequestSent;
-(void)onRequestError:(long)errorcode errorObj:(NSError*)error;
-(void)onRequestComplete:(NSData*)data;
@end
