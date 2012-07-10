//
//  Annotation.h
//  lab9_maps
//
//  Created by Lui Marciante on 12-03-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>{ CLLocationCoordinate2D coordinate; CLLocationDegrees latitude; CLLocationDegrees longitude;
    NSString *title; 
}

@property(nonatomic,readonly) CLLocationCoordinate2D coordinate; 
@property(nonatomic,copy) NSString *title; 
@property(nonatomic,copy) NSString *subtitle;

-(id) initWithLatitude:(CLLocationDegrees) lat longitude:(CLLocationDegrees) lng thetitle: (NSString *)t thesubtitle:(NSString *)sub;

@end
