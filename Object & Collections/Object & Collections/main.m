//
//  main.m
//  Object & Collections
//
//  Created by John Holsapple on 6/23/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        //
        // NSNumber, a lightweight wrapper around the number primitives
        
        NSNumber *aBool = [NSNumber numberWithBool:NO];
        NSLog(@"%@", [aBool boolValue] ? @"YES" : @"NO");
                          //^ Placeholder wildcard for any object.
        
        NSNumber *anInt = [NSNumber numberWithInt:157];
        NSLog (@"%d", [anInt intValue]);
                                            //^To get the int raw value.
         NSNumber *aLong = [NSNumber numberWithLong: 9223372036854775807];
         NSLog(@"%ld", [aLong longValue]);
         
         NSNumber *aFloat = [NSNumber numberWithFloat:26.99f];
         NSLog(@"%.2f", [aFloat floatValue]);
         
         NSNumber *aDouble = [NSNumber numberWithDouble: 123.67f];
         NSLog(@"%f", [aDouble doubleValue]);
        
        NSNumber *aNumber = [NSNumber numberWithInt: 12];
        float asFloat = [aNumber floatValue];
        NSLog(@"%f", asFloat);
        // ^ created an Integer and took out a float as the value
        
        NSString *asString = [aNumber stringValue];
        NSLog(@"%@", asString);
        
        // Using shortcuts Apple created for the above code
        NSNumber *success = @NO;
        NSNumber *lotteryPick = @15;
        NSNumber *unsignedInt = @384U;
        NSNumber *price = @26.99f;
        
        double x = 24.0f;
        NSNumber *result = @(x * 0.15f);
        NSLog(@"%@", result);
        
        NSNumber *bNumber = @12;
        NSNumber *anotherNumber = @12.0f;
        if ([bNumber isEqualToNumber: anotherNumber])
        {
            NSLog(@"Numbers are equal");
        }
        else
        {
            NSLog(@"Numbers are not equal");
        }
        
        NSNumber *aThirdNumber = @15;
        NSComparisonResult answer = [bNumber compare: aThirdNumber];
        if (answer == NSOrderedAscending)
        {
            NSLog(@"%@ < %@", bNumber, aThirdNumber);
        }
        else if (answer == NSOrderedSame)
        {
            NSLog(@"%@ == %@", bNumber, aThirdNumber);
        }
        else if (answer == NSOrderedDescending)
        {
            NSLog(@"%@ > %@", bNumber, aThirdNumber);
        }
       
        //Arrays - Two ways of declaring
        NSArray *shipCaptains = [NSArray arrayWithObjects:@"Malcolm Reynolds", @"Jean-Luc Picard", @"James T. Kirk", @"Han Solo", nil];
        NSArray *sameCaptains = @[@"Malcolm Reynolds", @"Jean-Luc Picard", @"James T. Kirk", @"Han Solo"];
        
        if ([shipCaptains isEqualToArray: sameCaptains])
        {
            NSLog(@"Arrays are equal");
        }
        
        if ([shipCaptains containsObject:@"Kathryn Janeway"])
        {
            NSLog(@"Janeway reporting for duty");
        }
        NSUInteger index = [shipCaptains indexOfObject:@"Kathryn Janeway"];
        if (index == NSNotFound)
        {
            NSLog(@"Captain not found!");
        }
        else
        {
            NSLog(@"Captain %@ was found at index %lu", shipCaptains[index], (unsigned long)index);
                                                                                 //^unsigned long integar
        }
        
        NSMutableArray *mutableShipCaptains = [[NSMutableArray alloc] initWithObjects:@"Malcolm Reynolds", @"James T. Kirk", nil];
        [mutableShipCaptains addObject:@"Han Solo"];
        [mutableShipCaptains addObjectsFromArray:@[@"Jean-Luc Picard", @"Kathryn Janeway"]];
        NSLog(@"%@", mutableShipCaptains);
        
        NSSortDescriptor *alphabetical = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        [mutableShipCaptains sortUsingDescriptors:@[alphabetical]];
        NSLog(@"%@", mutableShipCaptains);
        
        
        NSLog(@"Hello, World");
        
    }
    return 0;
}
