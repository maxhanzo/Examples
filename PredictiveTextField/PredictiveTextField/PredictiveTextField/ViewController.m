//
//  ViewController.m
//  AutocompleteTextField
//
//  Created by Max Ueda on 08/02/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblAutocompleteSuggestions.delegate = self;
    self.tblAutocompleteSuggestions.dataSource = self;
    self.txtInput.delegate = self;
    
    self.textEntries = @[@"HIROSHI", @"SATOSHI", @"MITSUYOSHI", @"TETSUO", @"YOSHIO", @"AKIRA", @"KAZUO", @"SEIJI", @"MAKOTO", @"TSUTOMU", @"TOSHIRO", @"MASAO", @"MITSUMASA"];
    
    //If your collection of data is sorted, you won't need this.
    self.textEntries =  [self.textEntries sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.textSuggestions = [NSMutableArray array];
}

-(void) searchData: (NSString*) data
{
    [self.textSuggestions removeAllObjects];
    
    for (NSString* item in self.textEntries)
    {
        if ([item rangeOfString:data
                        options:(NSAnchoredSearch | NSCaseInsensitiveSearch)].location != NSNotFound)
            [self.textSuggestions addObject:item];
    }
    
    [self.tblAutocompleteSuggestions reloadData];
}


-(void) clearData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.txtInput resignFirstResponder];
        [self.textSuggestions removeAllObjects];
        [self.tblAutocompleteSuggestions reloadData];
    });

}
#pragma mark - UITextFieldDelegate
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString* substring =   [self.txtInput.text  stringByReplacingCharactersInRange:range withString:string];
    [self searchData:substring];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self.txtInput setText: @""];
    return YES;
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.textSuggestions)
    {
        return [self.textSuggestions count];
    }
        
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    
    NSString* cellText = [self.textSuggestions objectAtIndex:indexPath.row];
    [cell.textLabel setText: cellText];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.txtInput setText: [self.textSuggestions objectAtIndex: indexPath.row]];
    [self clearData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
