//
//  Annotation.m
//  lab9_maps
//
//  Created by Lui Marciante on 12-03-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h" 

@implementation Annotation
@synthesize coordinate; 
@synthesize title; 
@synthesize subtitle;

//////////////////////////////

-(id) initWithLatitude:(CLLocationDegrees) lat longitude:(CLLocationDegrees) lng thetitle: (NSString *)t thesubtitle:(NSString *)sub{
    latitude = lat;
    longitude = lng;
    self.title = t;
    self.subtitle = sub;
    //pinColor = MKPinAnnotationColorGreen;
    CLLocationCoordinate2D coord = {latitude, longitude}; coordinate = coord;
    return self; 
}

/*-(void)dealloc{
    [super dealloc]; 
    [title release]; 
    [subtitle release];
}*/

@end