//
//  SkiArray.h
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface SkiArray {
    
    NSMutableArray *location;
    NSMutableArray *rundate;
    NSMutableArray *runtime;
    NSMutableArray *runpics;
}

@property(nonatomic,strong) NSMutableArray *location;
@property(nonatomic,strong) NSMutableArray *rundate;
@property(nonatomic,strong) NSMutableArray *runtime;
@property(nonatomic,strong) NSMutableArray *runpics;

@end
