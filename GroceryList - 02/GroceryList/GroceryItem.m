//
//  GroceryItem.m
//  GroceryList
//
//  Created by John Holsapple on 6/16/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "GroceryItem.h"

@implementation GroceryItem

// Model Object
+ (GroceryItem *)groceryItemWithDictionary:(NSDictionary *)groceryItemDict
{
    GroceryItem *anItem = nil;
    if (groceryItemDict)
    {
        anItem = [[GroceryItem alloc] init];
        anItem.name = [groceryItemDict objectForKey:@"name"];
        anItem.category = [groceryItemDict objectForKey:@"category"];
        anItem.aisle = [[groceryItemDict objectForKey:@"aisle"] integerValue];
    }
    return anItem;
}

@end
