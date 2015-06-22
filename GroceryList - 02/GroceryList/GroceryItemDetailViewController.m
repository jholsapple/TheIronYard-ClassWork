//
//  GroceryItemViewController.m
//  GroceryList
//
//  Created by John Holsapple on 6/16/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "GroceryItemDetailViewController.h"

@interface GroceryItemDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemAisleLabel;

@end

@implementation GroceryItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemNameLabel.text = self.groceryItem.name;
    self.itemCategoryLabel.text = self.groceryItem.category;
    self.itemAisleLabel.text = [NSString stringWithFormat:@"Aisle %ld", (long)self.groceryItem.aisle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
