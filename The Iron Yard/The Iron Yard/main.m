//
//  main.m
//  The Iron Yard
//
//  Created by John Holsapple on 6/18/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        Car *maserati = [[Car alloc] init];
        maserati.make = @"Maserati";
        maserati.model = @"Gran Turismo";
        maserati.color = @"Red";
        
        NSLog(@"My New Car: %@, %@, %@", maserati.make, maserati.model, maserati.color);
        
        Car *ferrari = [[Car alloc] initWithMake:@"Ferrari" model:@"458 Italia" andColor:@"Yellow"];
        NSLog(@"My Next Car: %@, %@, %@", ferrari.make, ferrari.model, ferrari.color);
        
        BOOL success = [ferrari drive];
        NSLog(@"my car, the %@ drove %@", ferrari.model, success ? @"Amazingly" : @"not at all");
                                                    //^ condition in Ternary Operator
        
    }
    return 0;
}
