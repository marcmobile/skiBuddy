//
//  MapViewController.m
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "Annotation.h"
#import "MapDetailViewController.h"

@implementation MapViewController
@synthesize myMapView;
@synthesize locationManager;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
    locationManager.distanceFilter = kCLDistanceFilterNone; 
    [locationManager startUpdatingLocation];

    CLLocation *myLocation = [locationManager location];    
    CLLocationCoordinate2D coordinate = [myLocation coordinate];
    
    CLLocationCoordinate2D location;

    
    location.latitude = 49.3; location.longitude = -123.09;
    myMapView.mapType = MKMapTypeHybrid;
    //myMapView.mapType = MKMapTypeStandard; 
    //myMapView.mapType = MKMapTypeSatellite;

    NSString *latitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude]; 
    NSString *longitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
    
    NSLog(@"%@",latitude);
    NSLog(@"%@",longitude);
    
    //MKCoordinateSpan span;
    //span.latitudeDelta = 1.04*(126.766667 - 66.95); //span.longitudeDelta = 1.04*(49.384472 - 24.520833);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location,30000,30000); //allows to specify region in meters
    //region.span = span; //region.center = location;
    [self.myMapView setRegion:region animated:YES];
    [self.myMapView regionThatFits:region]; 
    self.myMapView.delegate = self;
    
    ///////    Annotation
    Annotation *someAnnotation = [[Annotation alloc] initWithLatitude:50.1165 longitude:-122.9489 thetitle:@"Whistler" thesubtitle:@"2010 Winter Games Slopes!"];
    
    Annotation *someAnnotation2 = [[Annotation alloc] initWithLatitude:49.3337 longitude:-122.9629 thetitle:@"Seymour" thesubtitle:@"Great Local Mountain"];
 
    Annotation *someAnnotation3 = [[Annotation alloc] initWithLatitude:49.3706 longitude:-123.0991 thetitle:@"Grouse" thesubtitle:@"The Peak of Vancouver"];

    Annotation *someAnnotation4 = [[Annotation alloc] initWithLatitude:49.3860 longitude:-123.1835 thetitle:@"Cypress" thesubtitle:@"Vancouver's Big Mountain Experience"];
    
    [self.myMapView addAnnotation:someAnnotation]; 
    [self.myMapView addAnnotation:someAnnotation2]; 
    [self.myMapView addAnnotation:someAnnotation3]; 
    [self.myMapView addAnnotation:someAnnotation4];     

    Annotation *someAnnotation5 = [[Annotation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude thetitle:@"Your Here" thesubtitle:@"ME!"];
    
    //[self.myMapView addAnnotation:someAnnotation5]; 
    
    myMapView.showsUserLocation = YES;
    
    /*
    ///////    Pan
    UIButton *panButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    panButton.frame = CGRectMake(20, 20, 200, 44); 
    // position in the parent view and set the size of the button
    [panButton setTitle:@"Pan!" forState:UIControlStateNormal]; 
    [panButton addTarget:self action:@selector(panView:)forControlEvents:UIControlEventTouchUpInside]; 
    [self.view addSubview:panButton];
    
    ///////   Zoom 
    UIButton *zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    zoomButton.frame = CGRectMake(20, 80, 200, 44); // position in the parent view and set the size
    [zoomButton setTitle:@"Zoom!" forState:UIControlStateNormal]; 
    [zoomButton addTarget:self action:@selector(zoomView:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zoomButton];
    
    //////// Overlay
    //MKCircle *circle = [MKCircle circleWithCenterCoordinate:location radius:5000];
    //[self.myMapView addOverlay:circle];
    */
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//////////////////////// Pan and Zoom
-(void)panView:(id)sender{
    NSLog(@"pan the view");
    CLLocationCoordinate2D mapCenter = myMapView.centerCoordinate;
    mapCenter = [myMapView convertPoint:CGPointMake(1, (myMapView.frame.size.height/2.0))
                   toCoordinateFromView:myMapView];
    [self.myMapView setCenterCoordinate:mapCenter animated:YES];
}

-(void)zoomView:(id)sender{
    NSLog(@"zoom the view");
    MKCoordinateRegion theRegion = myMapView.region; // Zoom out
    theRegion.span.longitudeDelta *= 2.0; theRegion.span.latitudeDelta *= 2.0;
    [self.myMapView setRegion:theRegion animated:YES]; }

//////////////////////// Overlay

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay{
    MKCircleView* circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor blueColor];
    circleView.lineWidth = 5.0;
    //Uncomment below to fill in the circle                            
    circleView.fillColor = [UIColor yellowColor];
    return circleView;                            
}

//Custom Annotation

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation: 
(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if (pinView ==nil) {
        
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        pinView.pinColor = MKPinAnnotationColorGreen;
        pinView.animatesDrop = YES;
        
    } 

	if (annotation == mapView.userLocation) return nil;

	UIImage *anImage = nil;
	if([[annotation title] isEqualToString:@"Your Here"])
	{
		anImage=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user.jpeg" ofType:nil]];
	}
    else
    {
        anImage=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Snowflake1.png" ofType:nil]];
    }
    
	MKAnnotationView *anView=(MKAnnotationView*)[mapView  
												 dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
	
	if(anView==nil)
    {
		anView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
	}
	anView.image = anImage;
	anView.annotation=annotation;
	anView.canShowCallout=YES;
    anView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];

	return anView;	
}
////////////////////////

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	NSLog(@"I've been tapped");
    MapDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    //[self.navigationController presentModalViewController:detail animated:YES];
    [self.tabBarController presentViewController:detail animated:YES completion:NULL];
}

////////////////////////

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

@end
