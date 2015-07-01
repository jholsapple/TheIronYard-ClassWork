//
//  EventTableViewCell.h
//  IronEvents
//
//  Created by John Holsapple on 6/30/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UIView *trackColorView;
@property(weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
