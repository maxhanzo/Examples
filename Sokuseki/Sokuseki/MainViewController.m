//
//  MainViewController.m
//  TagTest
//
//  Created by Ticket Services on 12/13/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "MainViewController.h"
#import "ASJTagsView.h"
#import "NameSurnameInputViewController.h"
#import "YearInputTableViewController.h"
#import "PrefectureShipInputTableViewController.h"
#import "TagParameters.h"
#import "SearchParameters.h"
#import "Constants.h"
#import "Utilities.h"

@interface MainViewController ()
    @property (weak, nonatomic) IBOutlet ASJTagsView *tagsView;
    @property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
- (IBAction)clearAllTapped:(id)sender;

@end

@implementation MainViewController



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //TODO: Review this.
    if ([[segue identifier] isEqualToString:@"InputNameSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"Name";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputNameSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputSurnameSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        
        
        
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"Surname";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputSurnameSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputNameKanjiSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        
        
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"名前";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputNameKanjiSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputSurnameKanjiSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        
        nameSurnameInputRootViewController.navigationItem.title = @"名字";
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"名字";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputSurnameKanjiSegue"];
        }
    }

    
    else if ([[segue identifier] isEqualToString:@"InputYearSegue"])
    {
        UINavigationController* rootViewController = (UINavigationController*)segue.destinationViewController;
        YearInputTableViewController* yearInputTableViewController = (YearInputTableViewController*)[rootViewController.childViewControllers firstObject];
        
        yearInputTableViewController.navigationItem.title = @"Immigration Year";
        
        if(yearInputTableViewController)
        {
            [yearInputTableViewController setSegueID:@"InputYearSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputShipSegue"])
    {
        UINavigationController* rootViewController = (UINavigationController*)segue.destinationViewController;
        PrefectureShipInputTableViewController* shipInputTableViewController = (PrefectureShipInputTableViewController*)[rootViewController.childViewControllers firstObject];
        
        shipInputTableViewController.navigationItem.title = @"Ship";
        
        if(shipInputTableViewController)
        {
            [shipInputTableViewController setSegueID:@"InputShipSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputPrefectureSegue"])
    {
        UINavigationController* rootViewController = (UINavigationController*)segue.destinationViewController;
        PrefectureShipInputTableViewController* prefectureInputTableViewController = (PrefectureShipInputTableViewController*)[rootViewController.childViewControllers firstObject];
        
        prefectureInputTableViewController.navigationItem.title = @"Prefecture";
        
        if(prefectureInputTableViewController)
        {
            [prefectureInputTableViewController setSegueID:@"InputPrefectureSegue"];
        }
    }
    
    //Search
    else if ([[segue identifier] isEqualToString:@"SearchImmigrantSegue"])
    {
        NSArray *tagKeys = [self.tagTypes allKeys];
        SearchParameters* searchParameters = [SearchParameters getSharedInstance];
        for(NSString *tagKey in tagKeys)
        {
            NSNumber *tagKeyType = [self.tagTypes objectForKey: tagKey];
            NSInteger tagType = [tagKeyType integerValue];
            switch(tagType)
            {
                case  NAMETAG : searchParameters.immigrantName = tagKey;
                    break;
                case  SURNAMETAG : searchParameters.immigrantSurname = tagKey;
                    break;
                case  NAMEKANJITAG : searchParameters.immigrantNameKanji = tagKey;
                    break;
                case  SURNAMEKANJITAG: searchParameters.immigrantSurnameKanji = tagKey;
                    break;
                case  PREFECTURETAG: searchParameters.immigrantPrefecture = tagKey;
                    break;
                case  SHIPTAG: searchParameters.immigrantShip = tagKey;
                    break;
                case  YEARTAG:
                    searchParameters.immigrationYear = tagKey;
                    break;
                default: break;

            }
            
        }        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    [self handleTagBlocks];
    self.tagTypes = [[NSMutableDictionary alloc] init];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleTagBlocks
{
    __weak typeof(self) weakSelf = self;
    [_tagsView setTapBlock:^(NSString *tagText, NSInteger idx)
     {
        // NSString *message = [NSString stringWithFormat:@"You tapped: %@", tagText];
        // [weakSelf showAlertMessage:message];
     }];
    
    [_tagsView setDeleteBlock:^(NSString *tagText, NSInteger idx)
     {
         //NSString *message = [NSString stringWithFormat:@"You deleted: %@", tagText];
         //[weakSelf showAlertMessage:message];
         [weakSelf.tagsView deleteTagAtIndex:idx];
         
         NSNumber* inputTagType = [self.tagTypes objectForKey: tagText];
         if(inputTagType)
         {
             NSInteger tagTypeCode = [inputTagType integerValue];
             switch(tagTypeCode)
             {
                 case NAMETAG:
                 {
                     [self.btnNameInput setEnabled:YES];
                 } break;
                 case SURNAMETAG:
                 {
                     [self.btnSurnameInput setEnabled:YES];
                 } break;
                 case NAMEKANJITAG:
                 {
                     [self.btnNameKanjiInput setEnabled:YES];
                 } break;
                 case SURNAMEKANJITAG:
                 {
                     [self.btnSurnameKanjiInput setEnabled:YES];
                 } break;
                 case PREFECTURETAG:
                 {
                     [self.btnPrefectureInput setEnabled:YES];
                 } break;
                 case SHIPTAG:
                 {
                     [self.btnShipInput setEnabled:YES];
                 } break;
                 case YEARTAG:
                 {
                     [self.btnYearInput setEnabled:YES];
                 } break;
                 default:
                 {
                     [self clearAllTapped:nil];
                 } break;
             }
             
             [self.tagTypes removeObjectForKey: tagText];
         }
         
         
     }];
}

//Create search parameters
//
// Legacy stuff:
// #define NameKanjiKey 0
// #define NameRomajiKey 1
// #define SurnameKanjiKey 2
// #define SurnameRomajiKey 3
// #define ImmigrationYearKey 4
// #define PrefectureNameKey 5
// #define ShipNameKey 6

-(NSDictionary*) createSearchParameters
{

    NSMutableDictionary *shinAshiatoParameters = nil;
    NSArray *tagKeys  = [self.tagTypes allKeys];
    if([tagKeys count]>0)
    {
        shinAshiatoParameters = [NSMutableDictionary dictionary];
    }
    for(NSString *tagKey in tagKeys)
    {
        //Tag object contains the tag type. We need to adapt this because we're using legacy components.
        NSNumber *tagObject = [self.tagTypes objectForKey: tagKey];
        if(tagObject)
        {
            NSInteger sokusekiKey = [tagObject integerValue];
            switch (sokusekiKey)
            {
                case NAMETAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", NameRomajiKey]];
                } break;
                case SURNAMETAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", SurnameRomajiKey]];
                } break;
                case NAMEKANJITAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", NameKanjiKey]];
                } break;
                case SURNAMEKANJITAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", SurnameKanjiKey]];
                } break;
                case PREFECTURETAG:
                {
                    NSString *prefectureName = [Utilities removePrefectureSuffix:tagKey];
                    [shinAshiatoParameters setObject: prefectureName forKey: [NSString stringWithFormat: @"%i", PrefectureNameKey]];
                } break;
                case SHIPTAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", ShipNameKey]];
                } break;
                case YEARTAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", ImmigrationYearKey]];
                } break;
                default:break;
            }
        }
    }

    return shinAshiatoParameters;
}


-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
    TagParameters *tagParameters = [TagParameters getSharedInstance];
    
    if([segue.identifier isEqualToString:@"NameSurnameInputUnwindSegue"])
    {
        NSNumber *tagNumber = [NSNumber numberWithInteger: 0];
        if([self.windingActionID isEqualToString:@"InputNameSegue"])
        {
            //[self addTagWithTitle: @"Tadao"];
            //[self.tagTypes setObject: [NSNumber numberWithInt: NAMETAG] forKey: @"Tadao"];
            tagNumber = [NSNumber numberWithInt: NAMETAG];
            [self.btnNameInput setEnabled:NO];
            //TagParameters *tagParameters = [TagParameters getSharedInstance];
        }
        
        else if([self.windingActionID isEqualToString:@"InputSurnameSegue"])
        {
            //[self addTagWithTitle: @"Ueda"];
            //[self.tagTypes setObject: [NSNumber numberWithInt: SURNAMETAG] forKey: @"Ueda"];
            tagNumber = [NSNumber numberWithInt: SURNAMETAG];
            [self.btnSurnameInput setEnabled:NO];
        }
        
        else if([self.windingActionID isEqualToString:@"InputNameKanjiSegue"])
        {
            //[self addTagWithTitle: @"只雄"];
            //[self.tagTypes setObject: [NSNumber numberWithInt: NAMEKANJITAG] forKey: @"只雄"];
            tagNumber = [NSNumber numberWithInt: NAMEKANJITAG];
            [self.btnNameKanjiInput setEnabled:NO];
        }
        
        else if([self.windingActionID isEqualToString:@"InputSurnameKanjiSegue"])
        {
            //[self addTagWithTitle: @"上田"];
            //[self.tagTypes setObject: [NSNumber numberWithInt: SURNAMEKANJITAG] forKey: @"上田"];
            tagNumber = [NSNumber numberWithInt: SURNAMEKANJITAG];
            [self.btnSurnameKanjiInput setEnabled:NO];
        }
        
        NSString* parameter = tagParameters.parameter;
        [self addTagWithTitle: parameter];
        [self.tagTypes setObject: tagNumber forKey: parameter];
        
    }
    
    else if([segue.identifier isEqualToString:@"YearUnwindSegue"])
    {
        
        //[self addTagWithTitle: @"1955"];
        [self addTagWithTitle:tagParameters.parameter];
        [self.tagTypes setObject: [NSNumber numberWithInt: YEARTAG] forKey: tagParameters.parameter];
        [self.btnYearInput setEnabled:NO];
    }
    
    else if([segue.identifier isEqualToString:@"PrefectureShipUnwindSegue"])
    {
        if([self.windingActionID isEqualToString:@"InputPrefectureSegue"])
        {
            //[self addTagWithTitle: @"Yamaguchi"];
            [self addTagWithTitle:tagParameters.parameter];
            //[self.tagTypes setObject: [NSNumber numberWithInt: PREFECTURETAG] forKey: @"Yamaguchi"];
            [self.tagTypes setObject: [NSNumber numberWithInt: PREFECTURETAG] forKey: tagParameters.parameter];
            [self.btnPrefectureInput setEnabled:NO];
        }
        
        else if([self.windingActionID isEqualToString:@"InputShipSegue"])
        {
            //[self addTagWithTitle: @"America Maru"];
            [self addTagWithTitle:tagParameters.parameter];
            //[self.tagTypes setObject: [NSNumber numberWithInt: SHIPTAG] forKey: @"America Maru"];
            [self.tagTypes setObject: [NSNumber numberWithInt: SHIPTAG] forKey: tagParameters.parameter];
            [self.btnShipInput setEnabled:NO];
        }
        
    }
    
    [self setWindingActionID:@""];
    [tagParameters resetInstance];
}

- (void)addTagWithTitle: (NSString*) title
{
    [_tagsView addTag:title];
}


- (IBAction)clearAllTapped:(id)sender
{
    [_tagsView deleteAllTags];
    [self.btnNameInput setEnabled:YES];
    [self.btnSurnameInput setEnabled:YES];
    [self.btnNameKanjiInput setEnabled:YES];
    [self.btnSurnameKanjiInput setEnabled:YES];
    [self.btnPrefectureInput setEnabled:YES];
    [self.btnShipInput setEnabled:YES];
    [self.btnYearInput setEnabled:YES];
    [self.tagTypes removeAllObjects];
}


-(IBAction) searchImmigrant: (id) sender
{
    NSDictionary *shinAshiatoSearchParameters = [self createSearchParameters];
    if(shinAshiatoSearchParameters)
    {
        SearchParameters *searchParameters = [SearchParameters getSharedInstance];
        searchParameters.searchAshiatoParameters = shinAshiatoSearchParameters;
        [self performSegueWithIdentifier:@"SearchImmigrantSegue" sender:sender];
    }
    
    else
    {
        [self showAlertMessage:@"At least one parameter is needed."];
    }
}

- (void)showAlertMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - SWRevealViewController stuff
- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
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

//
//#pragma mark state preservation / restoration
//
//- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Save what you need here
//    
//    [super encodeRestorableStateWithCoder:coder];
//}
//
//
//- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Restore what you need here
//    
//    [super decodeRestorableStateWithCoder:coder];
//}
//
//
//- (void)applicationFinishedRestoringState
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Call whatever function you need to visually restore
//    [self customSetup];
//}

@end
