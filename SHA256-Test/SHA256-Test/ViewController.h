//
//  ViewController.h
//  SHA256-Test
//
//  Created by Max Ueda on 07/06/17.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UILabel *lblHashed;
@property (nonatomic, weak) IBOutlet UITextField *txtValue;

-(IBAction)generateHash:(id)sender;
-(NSString*) generateSHA256: (NSString*) inputString;
-(BOOL)isNullOrEmpty:(NSString*)string;
-(NSString*)hexDataToStringWithData:(NSData*)data withSpaces:(BOOL)spaces;

@end

