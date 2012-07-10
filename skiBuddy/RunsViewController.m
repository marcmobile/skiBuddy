//
//  RunsViewController.m
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RunsViewController.h"

@implementation RunsViewController
@synthesize myArray;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self loadArray];
    
    //NSError *error;
    
    self.title = @"Edit Table ";
    
    //reference to the docs folder, needs to be there to modify
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"skiRuns.plist"]; //add file name to path
    
    //manipulates files use nsfilemanager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: path]) //check and see if file does not exists
    {
        NSString *path2 = [documentsDirectory stringByAppendingPathComponent:@"skiRuns.plist"]; //add file name to path
        
        //read data back into the dictionary
        
        myArray = [[NSMutableArray alloc] initWithContentsOfFile: path2];
        
        NSLog(@"Got array");
        
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table view methods
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
    {
        
        return 1;
    }
    // Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
    {
        int count = [myArray count];
        if(self.editing) count++;
        
        NSLog(@"sdafjkjsdhfa");
        
        return count;
    }
    
    // Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        int count = 0;
        if(self.editing && indexPath.row != 0)
            count = 1;
        
        // Set up the cell...
        if(indexPath.row == ([myArray count]) && self.editing)
        {
            cell.textLabel.text = @"ADD";
            return cell;
        }
        
        cell.textLabel.text = [myArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        return cell;
    }

- (IBAction)AddButtonAction:(id)sender
    {
        [myArray addObject:@"Tutorial "];
        [Table reloadData];
    }
    
- (IBAction)DeleteButtonAction:(id)sender
    {
        [myArray removeLastObject];
        [Table reloadData];
    }
    
- (IBAction) EditTable:(id)sender
    {
        if(self.editing)
        {
            [super setEditing:NO animated:NO]; 
            [Table setEditing:NO animated:NO];
            [Table reloadData];
            [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
            [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
        }
        else
        {
            [super setEditing:YES animated:YES]; 
            [Table setEditing:YES animated:YES];
            [Table reloadData];
            [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
            [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
        }
    }
    
    // The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
    {
        // No editing style if not editing or the index path is nil.
        if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
        // Determine the editing style based on whether the cell is a placeholder for adding content or already 
        // existing content. Existing content can be deleted.    
        if (self.editing && indexPath.row == ([myArray count])) 
        {
            return UITableViewCellEditingStyleInsert;
        } else 
        {
            return UITableViewCellEditingStyleDelete;
        }
        return UITableViewCellEditingStyleNone;
    }
    
    // Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath 
    {
        
        if (editingStyle == UITableViewCellEditingStyleDelete) 
        {
            [myArray removeObjectAtIndex:indexPath.row];
            [Table reloadData];
        } else if (editingStyle == UITableViewCellEditingStyleInsert)
        {
            [myArray insertObject:@"Tutorial" atIndex:[myArray count]];
            [Table reloadData];
        }
    }
    
#pragma mark Row reordering
    // Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return YES;
    }

    // Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
toIndexPath:(NSIndexPath *)toIndexPath 
    {
        NSString *item = [myArray objectAtIndex:fromIndexPath.row];
        [myArray removeObject:item];
        [myArray insertObject:item atIndex:toIndexPath.row];
    }
    
@end
