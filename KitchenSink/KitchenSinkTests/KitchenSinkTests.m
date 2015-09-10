//
//  KitchenSinkTests.m
//  KitchenSinkTests
//
//  Created by John Holsapple on 8/13/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TIYAddition.h"

@interface KitchenSinkTests : XCTestCase
{
    TIYAddition *_addition;
}

@end

@implementation KitchenSinkTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _addition = [[TIYAddition alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAdditionClassExists
{
    XCTAssertNotNil(_addition, @"TIYAddition object should exists.");
}

- (void)testAddTwoPlusTwo
{
    int sum = [_addition addNumber:2 withNumber:2];
    XCTAssertEqual(sum, 4, @"Addition of 2 + 2 should be 4.");
}

- (void)testAddThreePlusSeven
{
    int sum = [_addition addNumber:3 withNumber:7];
    XCTAssertEqual(sum, 10, @"Addition of 3 + 7 should be 10");
}

@end
