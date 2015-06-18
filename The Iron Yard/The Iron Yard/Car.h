//
//  Car.h
//  The Iron Yard
//
//  Created by John Holsapple on 6/18/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (copy) NSString *make;
@property (copy) NSString *model;
@property (copy) NSString *color;

////////Method Delclartion/////////
- (instancetype)initWithMake:(NSString *)make
                       model:(NSString *)model
                    andColor:(NSString *)color;
    //^Returns instance of Car
- (BOOL)drive;

@end
