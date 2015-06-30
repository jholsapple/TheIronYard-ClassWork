//
//  Event.h
//  IronEvents
//
//  Created by John Holsapple on 6/30/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property(nonatomic)NSString *title;
@property(nonatomic)NSString *room;
@property(nonatomic)NSDate *date;
@property(nonatomic)NSInteger track;

-(instancetype)initWithTitle: (NSString *)title room:(NSString *)room date:(NSString *)date andTrack:(NSInteger)track;

-(instancetype)initWithDictionary:(NSDictionary *)eventDict;

@end
