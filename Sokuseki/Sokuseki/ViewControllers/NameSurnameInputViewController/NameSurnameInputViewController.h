//
//  NameSurnameInputViewController.h
//  TagTest
//
//  Created by Ticket Services on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameSurnameInputViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UITextField *txtInputNameSurname;
@property(nonatomic, strong) NSString *segueID;
-(IBAction)inputNameSurname:(id)sender;

@end
