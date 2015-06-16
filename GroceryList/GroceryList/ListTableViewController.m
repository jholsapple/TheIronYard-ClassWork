//
//  ListTableViewController.m
//  GroceryList
//
//  Created by John Holsapple on 6/16/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "ListTableViewController.h"
#import "GroceryItemDetailViewController.h"
#import "GroceryItem.h"

@interface ListTableViewController ()

{ // Variable declaration
    NSMutableArray *groceries;
}
// Method Declaration
- (void)loadGroceries;

@end

@implementation ListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    groceries = [[NSMutableArray alloc] init];
    [self loadGroceries];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [groceries count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroceryItemCell" forIndexPath:indexPath];
    
    GroceryItem *anItem = [groceries objectAtIndex:indexPath.row];
    cell.textLabel.text = anItem.name;
    cell.detailTextLabel.text = anItem.category;
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GroceryItemDetailSegue"])
    {
        GroceryItemDetailViewController *detailVC = segue.destinationViewController;
        
        
        UITableViewCell *selectedCell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
        GroceryItem *selectedGroceryItem = groceries[indexPath.row];
        detailVC.groceryItem = selectedGroceryItem;
    }
}


- (void)loadGroceries
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"groceries" ofType:@"json"];
    
    NSArray *groceriesJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    for (NSDictionary *aDict in groceriesJSON)
    {
        GroceryItem *anItem = [GroceryItem groceryItemWithDictionary:aDict];
        [groceries addObject:anItem];
    }
}

@end
