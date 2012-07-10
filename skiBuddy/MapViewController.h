//
//  MapViewController.h
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    MKMapView *myMapView;
    
}
@property(strong,nonatomic) IBOutlet MKMapView *myMapView;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end

