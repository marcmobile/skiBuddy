//
//  RunsViewController.h
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunsViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource> {

    IBOutlet UITableView *Table;
    NSMutableArray *myArray;

}

@property(nonatomic,strong) NSMutableArray *myArray;

- (IBAction) EditTable:(id)sender;

@end
