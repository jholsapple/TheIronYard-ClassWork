//
//  AddTipViewController.m
//  IronTips
//
//  Created by John Holsapple on 8/11/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "AddTipViewController.h"
#import <Parse/Parse.h>

@interface AddTipViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tipTextField;

- (IBAction)doneTapped:(UIBarButtonItem *)sender;
- (IBAction)cancelTapped:(UIBarButtonItem *)sender;

@end

@implementation AddTipViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
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

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addTipToParse];
    return YES;
}

#pragma mark - Action Handlers


- (IBAction)doneTapped:(UIBarButtonItem *)sender
{
    [self addTipToParse];
    
}

- (IBAction)cancelTapped:(UIBarButtonItem *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private

-(void)addTipToParse
{
    if (![self.tipTextField.text isEqualToString:@""])
    {
        PFObject *aNewTip = [PFObject objectWithClassName:@"Tip"];
        aNewTip[@"comment"] = self.tipTextField.text;
        PFRelation *relation = [aNewTip relationForKey:@"createdBy"];
        [relation addObject:[PFUser currentUser]];
        [aNewTip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded)
            {
                NSLog(@"A new tip was added to parse");
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                NSLog(@"Tip save failed: %@", [error localizedDescription]);
            }
        }];
    }
    else
    {
        [self.tipTextField becomeFirstResponder];
    }
}


@end
