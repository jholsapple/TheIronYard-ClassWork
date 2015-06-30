//
//  EventsTableViewController.m
//  IronEvents
//
//  Created by John Holsapple on 6/29/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "EventsTableViewController.h"
#import "EventTableViewCell.h"
#import "Event.h"

@interface EventsTableViewController ()
{
    NSArray *_events;
}

-(void) loadEvents;

@end

@implementation EventsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadEvents];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadEvents
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"meetups" ofType:@"json"];
    NSArray *events = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *multipleEvents = [[NSMutableArray alloc] init];
    
    for (NSDictionary *anEvent in events)
    {
        //Event *theEvent = [[Event alloc] initWithTitle:[anEvent objectForKey:@"title"] room:[anEvent objectForKey:@"room"] date:[anEvent objectForKey:@"date"] andTrack:[[anEvent objectForKey:@"track"] integerValue]];
        Event *theEvent = [[Event alloc] initWithDictionary:anEvent];
        
        [multipleEvents addObject:theEvent];
    }
    _events = [multipleEvents copy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventsCell" forIndexPath:indexPath];
    
    // Configure the cell...
     Event *anEvent = [_events objectAtIndex:indexPath.row];
     cell.titleLabel.text = anEvent.title;
     UIColor *trackColor;
     switch (anEvent.track)
     {
         case 1:
             trackColor = [UIColor colorWithRed:0.827 green:0.705 blue:0.168 alpha:1];
             break;
         case 2:
             trackColor = [UIColor colorWithRed:0.807 green:0.513 blue:0.176 alpha:1];
             break;
         case 3:
             trackColor = [UIColor colorWithRed:0.721 green:0.345 blue:0.298 alpha:1];
             break;
         default:
             trackColor = [UIColor blackColor];
             break;
     }
     cell. trackColorView.backgroundColor = trackColor;
     cell.trackColorView.layer.cornerRadius = cell.trackColorView.frame.size.width/2;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
 {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
