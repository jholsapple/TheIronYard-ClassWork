//
//  SettingsTableViewController.m
//  IronEvents
//
//  Created by John Holsapple on 6/29/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@property (weak, nonatomic) IBOutlet UIView *frontEndEngineeringCircle;
@property (weak, nonatomic) IBOutlet UIView *kidsClasses;
@property (weak, nonatomic) IBOutlet UIView *mobileEngineering;
@property (weak, nonatomic) IBOutlet UIView *railsEngineering;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.frontEndEngineeringCircle.layer.cornerRadius = self.frontEndEngineeringCircle.frame.size.width/2;
    self.kidsClasses.layer.cornerRadius = self.kidsClasses.frame.size.width/2;
    self.mobileEngineering.layer.cornerRadius = self.mobileEngineering.frame.size.width/2;
    self.railsEngineering.layer.cornerRadius = self.railsEngineering.frame.size.width/2;
    
    self.title = @"More";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
