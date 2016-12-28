//
//  NameSurnameInputViewController.m
//  TagTest
//
//  Created by Ticket Services on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "NameSurnameInputViewController.h"
#import "TagParameters.h"
#import "MainViewController.h"
@interface NameSurnameInputViewController ()

@end

@implementation NameSurnameInputViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.txtInputNameSurname resignFirstResponder];
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"NameSurnameInputUnwindSegue"])
    {
        // Get reference to the destination view controller
        MainViewController *mainViewController = (MainViewController*)[segue destinationViewController];
        
        if(mainViewController){
            [mainViewController setWindingActionID:self.segueID];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtInputNameSurname.delegate =self;
    [self.txtInputNameSurname becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)inputNameSurname:(id)sender;
{
    NSString* inputValue = self.txtInputNameSurname.text;
    if(inputValue)
    {
        TagParameters *tagParameters = [TagParameters getSharedInstance];
        NSString *trimmedInputValue =[inputValue stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        
        if (![trimmedInputValue isEqualToString: @""])
        {
            
        
        
        [tagParameters setParameter: [trimmedInputValue uppercaseString]];
            [self performSegueWithIdentifier:@"NameSurnameInputUnwindSegue" sender:self];
        }
        
        else
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                            message:@"Fill the field."
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
            [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
        }
    }


    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:@"Fill the field."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self inputNameSurname:nil];
    [self.txtInputNameSurname resignFirstResponder];
    return YES;
}


@end
