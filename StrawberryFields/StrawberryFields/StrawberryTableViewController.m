//
//  StrawberryTableViewController.m
//  StrawberryFields
//
//  Created by John Holsapple on 7/2/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "StrawberryTableViewController.h"

@interface StrawberryTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bandNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *songNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *albumNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *releaseYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *recordLabelTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalSalesTextField;

@end


@implementation StrawberryTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL returnValue = NO;
    if (textField == self.bandNameTextField)
    {
        if (![self.bandNameTextField.text isEqualToString:@""])
        {
            returnValue = YES;
            [self.songNameTextField becomeFirstResponder];
        }
    }
    else if (textField == self.songNameTextField)
    {
        if (![self.songNameTextField.text isEqualToString:@""])
        {
            returnValue = YES;
            [self.albumNameTextField becomeFirstResponder];
        }
    }
    else if (textField == self.albumNameTextField)
    {
        if (![self.albumNameTextField.text isEqualToString:@""])
        {
            returnValue = YES;
            [self.releaseYearTextField becomeFirstResponder];
        }
    }
    else if (textField == self.releaseYearTextField)
    {
        if ([self.releaseYearTextField.text length] == 4)
        {
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            if ([self.releaseYearTextField.text rangeOfCharacterFromSet:set].location != NSNotFound)
            {
                returnValue = YES;
                [self.recordLabelTextField becomeFirstResponder];
            }
        }
    }
    else if (textField == self.recordLabelTextField)
    {
        if (![self.recordLabelTextField.text isEqualToString:@""])
        {
            returnValue = YES;
            [self.totalSalesTextField becomeFirstResponder];
        }
    }
    else if (textField == self.totalSalesTextField)
    {
        if (![self.totalSalesTextField.text isEqualToString:@""])
        {
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            if ([self.totalSalesTextField.text rangeOfCharacterFromSet:set].location != NSNotFound)
            {
                returnValue = YES;
                [self.totalSalesTextField resignFirstResponder];
            }
        }
    }
    if (returnValue == NO)
    {
        self.tableView.backgroundColor = [UIColor redColor];
    }
    else
    {
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    
    return returnValue;
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
