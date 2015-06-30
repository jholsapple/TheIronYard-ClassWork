//
//  Event.m
//  IronEvents
//
//  Created by John Holsapple on 6/30/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)initWithTitle:(NSString *)title room:(NSString *)room date:(NSString *)date andTrack:(NSInteger)track
{
    self = [super init];
    if (self)
    {
        _title = title;
        _room = room;
        _track = track;
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
                                        //2015-07-27 18:30 EDT
        [f setDateFormat:@"yyyy-MM-dd HH:mm zzz"];
        _date = [f dateFromString:date];
    }
    
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)eventDict
{
    self = [super init];
    if (self)
    {
        _title = [eventDict objectForKey:@"title"];
        _room = [eventDict objectForKey:@"room"];
        _track = [[eventDict objectForKey:@"track"] integerValue];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        //2015-07-27 18:30 EDT
        [f setDateFormat:@"yyyy-MM-dd HH:mm zzz"];
        _date = [f dateFromString:[eventDict objectForKey:@"date"]];
    }
    
    return self;
}

@end
