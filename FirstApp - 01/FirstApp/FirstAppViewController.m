//
//  ViewController.m
//  FirstApp
//
//  Created by Ben Gohlke on 6/15/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FirstAppViewController.h"

@interface FirstAppViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISwitch *changeColorSwitch;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation FirstAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.text = @"";
    self.messageLabel.text = @"";
    self.changeColorSwitch.on = NO;
}

- (IBAction)switchValueChanged:(UISwitch *)sender
{
    if (sender.on == YES)
    {
        self.view.backgroundColor = [UIColor greenColor];
    }
    else
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        rc = YES;
        NSArray *nameComponents = [textField.text componentsSeparatedByString:@" "];
        NSString *greeting = [NSString stringWithFormat:@"Hello, %@", nameComponents[0]];
        self.messageLabel.text = greeting;
    }
    
    return rc;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
