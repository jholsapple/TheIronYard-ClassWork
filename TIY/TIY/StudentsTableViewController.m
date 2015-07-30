//
//  StudentsTableViewController.m
//  TIY
//
//  Created by John Holsapple on 7/28/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "StudentsTableViewController.h"
#import "StudentCell.h"
#import "Student.h"
#import "CoreDataStack.h"

@interface StudentsTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *students;
    CoreDataStack *cdStack;
}

- (IBAction)addStudent:(UIBarButtonItem *)sender;

@end

@implementation StudentsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    students = [[NSMutableArray alloc] init];
    cdStack = [CoreDataStack coreDataStackWithModelName:@"TIYModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:cdStack.managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = entity;
    students = nil;
    students = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil]mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    UIView *contentView = [textField superview];
    StudentCell *cell = (StudentCell *)[contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Student *aStudent = students[indexPath.row];
    
    if (![textField.text isEqualToString:@""])
    {
        rc = YES;
        if ([textField.placeholder isEqualToString:@"Name"])
        {
            aStudent.firstName = [textField.text componentsSeparatedByString:@" "][0];
            aStudent.lastName = [textField.text componentsSeparatedByString:@" "][1];
            
            if (aStudent.ageValue > 0)
            {
                [textField resignFirstResponder];
                [self saveCoreDataUpdates];
            }
            else
            {
                [cell.ageTextField becomeFirstResponder];
            }
        }
        if ([textField.placeholder isEqualToString:@"Age"])
        {
            aStudent.ageValue = [textField.text intValue];
            
            if (![aStudent.firstName isEqualToString:@""] && ![aStudent.lastName isEqualToString:@""])
            {
                [textField resignFirstResponder];
                [self saveCoreDataUpdates];
            }
            else
            {
                [cell.nameTextField becomeFirstResponder];
            }
        }
    }
    return rc;
}

- (void)saveCoreDataUpdates
{
    [cdStack saveOrFail:^(NSError *errorOrNil)
    {
        if (errorOrNil)
        {
            NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    
    Student *aStudent = students[indexPath.row];
    if (!aStudent.firstName || !aStudent.lastName)
    {
        [cell.nameTextField becomeFirstResponder];
    }
    else
    {
        [cell.nameTextField setText:[NSString stringWithFormat:@"%@ %@", aStudent.firstName, aStudent.lastName]];
        if (aStudent.ageValue > 0)
        {
            cell.ageTextField.text = [NSString stringWithFormat:@"%d", aStudent.ageValue];
        }
    }
    
    return cell;
}

- (IBAction)addStudent:(UIBarButtonItem *)sender
{
    Student *aStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:cdStack.managedObjectContext];
    [students addObject:aStudent];
    NSInteger index = [students indexOfObject:aStudent];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
