//
//  MyBoardHandler.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyBoardHandler.h"
#import "MyHttpRequest.h"
#import "MyDataManager.h"
#import "Board.h"
static NSString * const kBoardPathPart = @"boards";
@implementation MyBoardHandler

-(id)processData:(NSData*) data error: (NSError**) error
{
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
    
    
    if(error)
    {
        NSLog(@"after json parse %@=%@",*error,(*error).localizedDescription);
    }
    //store
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Board" inManagedObjectContext:[MyDataManager sharedInstance].managedObjectContext];
    Board *newBoard = [[Board alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:[MyDataManager sharedInstance].managedObjectContext];
    NSDictionary *attributes = [[newBoard entity] attributesByName];
    NSArray* jsonDictArr = [jsonDict objectForKey:@"body"];
    for(NSDictionary* itemDic in jsonDictArr)
    {
        for (NSString *attribute in attributes) {
            id value = [itemDic objectForKey:attribute];
            NSLog(@"value:%@,key:%@",value,attribute);
            if (value == nil) {
                continue;
            }
            [newBoard setValue:value forKey:attribute];
        }
        
        
        if (![newBoard.managedObjectContext save:error]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", *error, (*error).localizedDescription);
        }
        //todo if last item in itemDic do not creat newBoard
        newBoard = [[Board alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:[MyDataManager sharedInstance].managedObjectContext];
        
    }
    
    
    
    //fetch test
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Board" inManagedObjectContext:[MyDataManager sharedInstance].managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error2 = nil;
    NSArray *result = [[MyDataManager sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error2];
    
    if (error2) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
        
    } else {
        for(Board* obj in result)
        {
            NSLog(@"Test Entity attr=%@",obj.src);
        }
    }

    return newBoard;
}
-(NSURL*)getCallPath
{
    NSString* urlStr = [NSString stringWithFormat:@"%@%@/%@",kPinterestApiAddress,self.userName,kBoardPathPart ];
    NSLog(@"url:%@",urlStr);
    return [NSURL URLWithString:urlStr];
}
@end
