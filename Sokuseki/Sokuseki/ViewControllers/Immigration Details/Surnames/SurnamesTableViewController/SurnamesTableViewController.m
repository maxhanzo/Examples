//
//  SurnamesTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "SurnamesTableViewController.h"
#import "DBManager.h"

@interface SurnamesTableViewController ()

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property(nonatomic, strong) NSArray *surnamesArray;
@property(nonatomic, strong) NSArray *searchResults;

@end

@implementation SurnamesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithAllData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TopTenSurnameTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TopTenSurnameTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RegularSurnameTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RegularSurnameTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.revealViewController.delegate = self;
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    
    [self.searchDisplayController.searchResultsTableView reloadData];
    [self.tableView reloadData];
}

-(NSInteger) calculateTotalNumberOfImmigrants
{
    NSInteger total = 0;
    Surname *surname = [self.surnamesArray objectAtIndex:0];
    if(surname)
    {
        total = [surname.numberOfImmigrants integerValue];
    }
    
    return total;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    }
    else
    {
        return [self.surnamesArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger totalNumberOfImmigrants = [self calculateTotalNumberOfImmigrants];

    
    Surname  *surname = nil;
    if (self.tableView != self.searchDisplayController.searchResultsTableView)
    {
        surname = [self.surnamesArray objectAtIndex: indexPath.row];
        if(indexPath.row <10)
        {
            TopTenSurnameTableViewCell *cell = (TopTenSurnameTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"TopTenSurnameTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopTenSurnameTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            [cell setDataWithSurname: surname withRankingPosition: [NSNumber numberWithInteger: (indexPath.row + 1)]];
            [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: totalNumberOfImmigrants]];
            [cell setRanking: (indexPath.row + 1)];
            
            return cell;
        }
        
        RegularSurnameTableViewCell *cell = (RegularSurnameTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"RegularSurnameTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RegularSurnameTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        
        [cell setDataWithSurname: surname];
        [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: totalNumberOfImmigrants]];
        return cell;

    
    }
    
    else
    {
        surname  = [self.searchResults objectAtIndex: indexPath.row];
  
        NSInteger totalNumberOfImmigrants = [self calculateTotalNumberOfImmigrants];
        RegularSurnameTableViewCell *cell = (RegularSurnameTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"RegularSurnameTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RegularSurnameTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        
        [cell setDataWithSurname: surname];
        [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: totalNumberOfImmigrants]];
        return cell;
    }
    
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TopTenSurnameTableViewCell rowHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


-(void) initWithAllData
{
    DBManager *dbManager = [DBManager getSharedInstance];
    self.surnamesArray = [dbManager retrieveAllSurnames];
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.surnamesArray count]];

}
#pragma mark - SWRevealViewController stuff
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if (revealController.frontViewPosition == FrontViewPositionRight) {
        UIView *lockingView = [UIView new];
        lockingView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:revealController action:@selector(revealToggle:)];
        [lockingView addGestureRecognizer:tap];
        [lockingView addGestureRecognizer:revealController.panGestureRecognizer];
        [lockingView setTag:9999];
        [revealController.frontViewController.view addSubview:lockingView];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(lockingView);
        
        [revealController.frontViewController.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"|[lockingView]|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        [revealController.frontViewController.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lockingView]|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        [lockingView sizeToFit];
    }
    else{
        [[revealController.frontViewController.view viewWithTag:9999] removeFromSuperview];
        [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}

#pragma mark SearchDisplay Delegate
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"romaji contains[cdu] %@", searchText];
    self.searchResults = [NSMutableArray arrayWithArray:[_surnamesArray filteredArrayUsingPredicate:resultPredicate]];
    [self.searchDisplayController.searchResultsTableView reloadData];
    
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    dispatch_async(main_queue, ^{
        [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
        
    });
    return NO;
}



@end
