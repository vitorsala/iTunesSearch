//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *textoBusca;

- (IBAction)buscar:(id)sender;
@end

