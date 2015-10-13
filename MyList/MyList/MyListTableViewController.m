//
//  MyListTableViewController.m
//  MyList
//
//  Created by John Holsapple on 7/1/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "MyListTableViewController.h"
#import "Student.h"

@interface MyListTableViewController ()
{
    NSArray *theStudents;
}

@end

@implementation MyListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //theStudents = [[NSArray alloc] initWithObjects:@"Ben", @"Ian", @"John", nil];
    
    NSArray *seedData = @[@{@"name": @"Ben", @"age": @31, @"course": @"iOS"}, @{@"name": @"Ian", @"age": @22, @"course": @"iOS"}, @{@"name": @"John", @"age": @32, @"course": @"iOS"}];
    
    NSMutableArray *studentStorage = [[NSMutableArray alloc] init];
    
    for (NSDictionary *seed in seedData)
    {
        Student *aStudent = [[Student alloc] init];
        aStudent.name = seed[@"name"];
        aStudent.age =  [seed[@"age"] intValue];
        aStudent.course = seed[@"course"];
        
        [studentStorage addObject:aStudent];
    }
    
    /*Student *aStudent = [[Student alloc] init];
    aStudent.name = @"Ben";
    aStudent.age = 31;
    aStudent.course = @"iOS";
    
    Student *anotherStudent = [[Student alloc] init];
    anotherStudent.name = @"Ian";
    anotherStudent.age = 22;
    anotherStudent.course = @"iOS";
     */
    
    theStudents = [studentStorage copy];
    self.title = @"Summer iOS";
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
    return [theStudents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Student *theStudent = theStudents[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %d  %@", theStudent.name, theStudent.age, theStudent.course];
    
    return cell;
}



@end
