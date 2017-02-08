//
//  ViewController.m
//  AutocompleteTextField
//
//  Created by Max Ueda on 08/02/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "ViewController.h"
#import "SecondSceneViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblAutocompleteSuggestions.delegate = self;
    self.tblAutocompleteSuggestions.dataSource = self;
    self.txtSearchBar.delegate = self;
    
    self.textEntries = @[@"HIROSHI", @"MASUTATSU", @"ASAEMON", @"SATOSHI", @"MITSUYOSHI", @"TETSUO", @"YOSHIO", @"AKIRA", @"KAZUO", @"SEIJI", @"TATSUMI", @"MAKOTO", @"SETSUO" , @"AMAKAGE", @"TSUTOMU", @"HIDEO", @"KENJIRO", @"TOSHIRO", @"MASAO", @"KOICHI", @"MITSUMASA"];
    
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
        [self.textSuggestions removeAllObjects];
        [self.tblAutocompleteSuggestions reloadData];
    });

}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchData:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self performSegueWithIdentifier:@"SecondSceneSegue" sender:self];
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

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.txtSearchBar resignFirstResponder];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.txtSearchBar setText: [self.textSuggestions objectAtIndex: indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"SecondSceneSegue" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue stuff
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SecondSceneSegue"])
    {
        SecondSceneViewController *secondSceneViewController = (SecondSceneViewController*)[segue destinationViewController];
        
        if(secondSceneViewController){
            [secondSceneViewController setStrTitle: self.txtSearchBar.text];
        }
    }
}


@end
