//
//  TipsTableViewController.m
//  IronTips
//
//  Created by John Holsapple on 8/6/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "TipsTableViewController.h"
#import "TipCell.h"
#import <Parse/Parse.h>

@interface TipsTableViewController ()
{
    NSArray *tips;
}

@end

@implementation TipsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTapped:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTipsFromParse];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"ShowLoginModalSegue" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
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
    return [tips count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TipCell" forIndexPath:indexPath];
    
    PFObject *aTip = tips[indexPath.row];
    cell.commentLabel.text = aTip[@"comment"];
    
    PFRelation *userCreated = aTip[@"createdBy"];
    [userCreated.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            id anObject = objects[0];
            if ([anObject isKindOfClass:[PFUser class]])
            {
                PFUser *user = anObject;
                cell.userLabel.text = [NSString stringWithFormat:@"%@ says...", user.username];
            }
        }
    }];
    
    return cell;
}

#pragma mark - Action Handlers

- (void)refreshTapped:(UIBarButtonItem *)sender
{
    [self refreshTipsFromParse];
}

#pragma mark - Private

- (void)refreshTipsFromParse
{
    if ([PFUser currentUser])
    {
        PFQuery *query = [[PFQuery alloc] initWithClassName:@"Tip"];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                              if (!error)
                              {
                                  tips = objects;
                                  [self.tableView reloadData];
                              }
                          }];
    }
}

@end
