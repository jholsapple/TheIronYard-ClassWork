//
//  GroceryItem.h
//  GroceryList
//
//  Created by John Holsapple on 6/16/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroceryItem : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *category;
@property (assign) NSInteger aisle;

+ (GroceryItem *)groceryItemWithDictionary:(NSDictionary *) groceryItemDict;

@end
