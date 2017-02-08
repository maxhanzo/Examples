//
//  ViewController.h
//  AutocompleteTextField
//
//  Created by Max Ueda on 08/02/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) IBOutlet UISearchBar *txtSearchBar;
@property(nonatomic, weak) IBOutlet UITableView *tblAutocompleteSuggestions;
@property(nonatomic, strong) NSArray *textEntries;
@property(nonatomic, strong) NSMutableArray *textSuggestions;


@end

