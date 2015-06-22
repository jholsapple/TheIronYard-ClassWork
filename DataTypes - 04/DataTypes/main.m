//
//  main.m
//  DataTypes
//
//  Created by John Holsapple on 6/18/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
    //Primitive values @ 32 bits wide                                               // insert code here...
        int stuff = -2147483648;
        unsigned int positiveStuff = 4294967295;
    // Long Integar @ 64 bits wide
        long aLong = -9223372036854;
        unsigned long unsignedLong = 1744674407;
    // Float @ 32 bits wide
        float aFloat = -21.09f;
    // Double @ 64 bits wide
        double aDouble = -21.09f;
    // Long Double @ 80 bits wide
        long double aLongDouble = 21.09e8L;
        
    //
    // Math
    //
        
        int intergerResult = 5 / 4;
        NSLog(@"Interger division: %d", intergerResult);
                                  //^ wildcard placeholder for integers
        float floatResult = 5.0 / 4;
        NSLog(@"Floating point division: %f", floatResult);
                                        //^ wildcard placeholder for floats and doubles
        NSLog(@"%.2f", floatResult);
              //^ customizes amount of decimals spaces
        
    // Objective-C Primitives
        BOOL aBool = YES;
        NSLog(@"%d", aBool);
        NSLog(@"%@", aBool ? @"YES" : @"NO");
                    //^ Ternary Operator
        
    // Objective-C Objects
        NSString *myString = @"Hello, World";
        NSLog(@"%@", myString);
              //^ wildcard placeholder for strings
        
        id mysteryObject = @"An NSString object";
      //^Any object
        NSLog(@"%@", mysteryObject);
        mysteryObject = @{@"model": @"Ford", @"Year": @1967};
        NSLog(@"%@", mysteryObject);       //^String  ^Object
        
        
        
        
    }
    return 0;
}
