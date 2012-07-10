//
//  SkiArray.m
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SkiArray.h"

@implementation SkiArray
@synthesize location = _location;
@synthesize rundate = _rundate;
@synthesize runtime = _runtime;
@synthesize runpics = _runpics;

- (void)loadArray
{
    ///////////LOAD Arrays with Data
    
    NSError *error;
    
    //reference to the docs folder, needs to be there to modify
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"skiRuns.plist"]; //add file name to path
    
    //manipulates files use nsfilemanager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //check and see if file does not exists
    {
        NSString *temp = [[NSBundle mainBundle] resourcePath];
        NSString *bundle =  [temp stringByAppendingPathComponent:@"list.plist"];
        //copy the plist file
        [fileManager copyItemAtPath:bundle toPath:path error:&error]; //copy file from bundle to doc folder
        
        NSLog(@"copying file over");
    }
    
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:@"skiRuns.plist"]; //add file name to path
    
    //another example of writing out a dictionary to a plist
    
    _location = [[NSMutableArray alloc] initWithObjects:@"All Runs", nil];
    //NSMutableArray *rowDesc = [[NSMutableArray alloc] initWithObjects:@"located in north america",@"our neighbor to the south",@"part of the EU", nil];
    //save to the plist
    [_location  writeToFile:path2 atomically:YES];
    //[rowDesc  writeToFile:path2 atomically:YES];   
    
    //[myArray addObject:myNumber];
    NSLog(@"Array saved to PLIST");
    
}

@end
