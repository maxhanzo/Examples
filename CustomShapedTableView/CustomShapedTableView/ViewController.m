//
//  ViewController.m
//  CustomShapedTableView
//
//  Created by Max Ueda on 8/22/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//
//  Present on Ticket's Estabelecimento App (will be published soon).

#import "ViewController.h"
#import "AnticipateContractTermsTableViewCell.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.myTable.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.termsAndConditionsMode = TermsAndConditionsVisible;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//TableView can have two or three rows, depending of the "Display Mode"
//Our client told us that users don't necessarily want to read the terms and conditions,
//hence, the option of hiding/unhiding should be given to them.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.termsAndConditionsMode)
    {
        case TermsAndConditionsInvisible:
            return 2;
        case TermsAndConditionsVisible:
            return 3;
        default: return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    switch ( indexPath.row )
    {
        case 0:
        {
            ManualAnticipationTableViewCell *manualAnticipationCell = (ManualAnticipationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ManualAnticipationTableViewCell"];
            
            if(!manualAnticipationCell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ManualAnticipationTableViewCell" owner:self options:nil];
                manualAnticipationCell = [nib objectAtIndex:0];
            }
            [manualAnticipationCell.btnAnticipate addTarget:self action:@selector(confirmAnticipation) forControlEvents:UIControlEventTouchUpInside];
            
            
            self.manualAnticipationTableViewCell = manualAnticipationCell;
            //In the original app, those values come from an API.
            [self.manualAnticipationTableViewCell.lblValue setText: @"10,000.00"];
            [self.manualAnticipationTableViewCell.lblRate setText: @"$ 34.56"];
            return manualAnticipationCell;
        }   break;
        case 1:
        {
            AnticipateContractTermsTableViewCell *automaticAnticipationCell = (AnticipateContractTermsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AnticipateContractTermsTableViewCell"];
            
            if(!automaticAnticipationCell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AnticipateContractTermsTableViewCell" owner:self options:nil];
                automaticAnticipationCell = [nib objectAtIndex:0];
                
                //self.agreeWithTerms = automaticAnticipationCell.btnCheck.isSelected - This won't work,
                //because btnCheck is a weak reference. IBOutlets aren't meant to retain anything.
                self.agreeWithTerms = YES;
                [automaticAnticipationCell.btnCheck addTarget:self action:@selector(checkUncheckAgreeWithTerms) forControlEvents:UIControlEventTouchUpInside];
                
                //Toggles Terms and Conditions TableViewCell
                [automaticAnticipationCell.btnToggleTermsConditions addTarget: self action:@selector(updateHeightTermsCellHeight) forControlEvents: UIControlEventTouchUpInside];
                NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                [style setAlignment:NSTextAlignmentCenter];
                
                UIFont *font = [UIFont fontWithName:@"Roboto-Regular" size:11.0f];
                
                NSDictionary *attributes = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                             NSFontAttributeName:font,
                                             NSParagraphStyleAttributeName:style,
                                             };
                
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
                [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"terms and conditions"    attributes:attributes]];
                
                [automaticAnticipationCell.btnToggleTermsConditions setAttributedTitle:attributedString forState:UIControlStateNormal];
                [[automaticAnticipationCell.btnToggleTermsConditions titleLabel] setNumberOfLines:0];
            }
            return automaticAnticipationCell;
        } break;
        case 2:
        {
            CellIdentifier = @"TermsAndConditionsTableViewCell";
            TermsAndConditionsTableViewCell *termsAndConditionsTableViewCell = (TermsAndConditionsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TermsAndConditionsTableViewCell"];
            
            if(!termsAndConditionsTableViewCell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TermsAndConditionsTableViewCell" owner:self options:nil];
                termsAndConditionsTableViewCell = [nib objectAtIndex:0];
            }
            
            [termsAndConditionsTableViewCell setHTMLWithFileName:@"TermsAndConditions"];
            [termsAndConditionsTableViewCell.btnArrowUp addTarget: self action:@selector(updateHeightTermsCellHeight) forControlEvents:UIControlEventTouchUpInside];
            self.termsAndConditionsTableViewCell = termsAndConditionsTableViewCell;
            return termsAndConditionsTableViewCell;
            
        }   break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    switch ( indexPath.row )
    {
        case 0:
            cellHeight = [ManualAnticipationTableViewCell rowHeight];
            break;
        case 1:
            cellHeight = [AnticipateContractTermsTableViewCell rowHeight];
            break;
        case 2:
            cellHeight = [self.termsAndConditionsTableViewCell rowHeight];
            break;
        default:
            cellHeight = 44.0f;
            break;
    }
    
    return cellHeight;
    
}

-(void) updateHeightTermsCellHeight
{
    //Toggling
    self.termsAndConditionsMode = self.termsAndConditionsMode == TermsAndConditionsVisible ? TermsAndConditionsInvisible: TermsAndConditionsVisible;
    
    [self adjustHeightOfTableView];
    [self.myTable reloadData];
}

//Adjusts CustomShapedTableView height according to the numbers of products to be displayed
- (void)adjustHeightOfTableView
{
    CGFloat fullSize = [ManualAnticipationTableViewCell rowHeight] + [AnticipateContractTermsTableViewCell rowHeight] + 219.5;
    
    CGFloat partialSize = [ManualAnticipationTableViewCell rowHeight] + [AnticipateContractTermsTableViewCell rowHeight];
    
    self.tableViewHeightConstraint.constant = (self.termsAndConditionsMode == TermsAndConditionsVisible) ? fullSize: partialSize;
 
    [self.myTable setNeedsDisplay];
}

-(void) confirmAnticipation
{

        if(self.agreeWithTerms)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message: @"Anticipation succeeded!"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];

        }
        
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message: @"You must agree to our terms and conditions. Click on \"I agree with the terms and conditions\""
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
}

#pragma mark - UITableViewCell Targets
-(void) checkUncheckAgreeWithTerms
{
    self.agreeWithTerms = !self.agreeWithTerms;
}


@end
