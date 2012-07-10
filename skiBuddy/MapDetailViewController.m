//
//  MapDetailViewController.m
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapDetailViewController.h"
#import "Annotation.h"

@implementation MapDetailViewController

@synthesize myMapView;
@synthesize locationManager;
@synthesize stopWatchLabel;
@synthesize imgPicker;
@synthesize myArray;
@synthesize myArray1;

int butSel = 0;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
/////////////////////////

- (void)loadArray
{
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
    myArray = [[NSMutableArray alloc] initWithContentsOfFile:path2];
    //NSMutableArray *rowDesc = [[NSMutableArray alloc] initWithObjects:@"located in north america",@"our neighbor to the south",@"part of the EU", nil];
    
    //save to the plist
    //[myArray writeToFile:path2 atomically:YES];
    //[rowDesc  writeToFile:path2 atomically:YES];   
    
    //[myArray addObject:myNumber];
    NSLog(@"Array Loaded");
    
}

/////////////////////////

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myArray1 = [[NSMutableArray alloc] initWithObjects:nil];
    
    CLLocationCoordinate2D location;
    //49.3337 longitude:-122.9629
    location.latitude = 49.3337; location.longitude = -122.9629;
    myMapView.mapType = MKMapTypeHybrid;
    //myMapView.mapType = MKMapTypeStandard; 
    //myMapView.mapType = MKMapTypeSatellite;
    
    //MKCoordinateSpan span;
    //span.latitudeDelta = 1.04*(126.766667 - 66.95); //span.longitudeDelta = 1.04*(49.384472 - 24.520833);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location,5000,5000); //allows to specify region in meters
    //region.span = span; //region.center = location;
    [self.myMapView setRegion:region animated:NO]; 
    [self.myMapView regionThatFits:region]; 
    self.myMapView.delegate = self;
    
    ///////    Annotation
    Annotation *someAnnotation = [[Annotation alloc] initWithLatitude:49.3337 longitude:-122.9629 thetitle:@"Seymour" thesubtitle:@"Great Local Mountain"];
    
    [self.myMapView addAnnotation:someAnnotation]; 
    
    [self loadArray];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setStopWatchLabel:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

///////////////////


- (void)saveArray
{
    //reference to the docs folder, needs to be there to modify
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"skiRuns.plist"]; //add file name to path
    
    //manipulates files use nsfilemanager
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:@"skiRuns.plist"]; //add file name to path

    //save to the plist
    [myArray addObject:@"new run"];
    [myArray writeToFile:path2 atomically:YES];
    
    NSLog(@"Array write");
    
}
///////////////////////////

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
    anView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeCustom];
    
	return anView;	
}
////////////////////////

-(IBAction)closeWindow{
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    stopWatchLabel.text = timeString;
    //[dateFormatter release];
}

-(IBAction)clickRun{
    //[myRun setImage:[UIImage imageNamed:@"stop-icon.png"] forState:UIControlStateSelected];
    
    if (butSel == 0)
    {   
        butSel = 1;
        startDate = [NSDate date];
        [myRun setImage:[UIImage imageNamed:@"stop-icon.png"] forState:UIControlStateSelected];
        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                          target:self
                                                        selector:@selector(updateTimer)
                                                        userInfo:nil
                                                         repeats:YES];
        
        //[myRun setImage:[UIImage imageNamed:@"start-icon.png"] forState:UIControlStateNormal];
    }
    else
    {
        butSel = 0;
        [myRun setImage:[UIImage imageNamed:@"start-icon.png"] forState:UIControlStateSelected];
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
        [self updateTimer]; 
        
        [self saveArray];
    }
    
}

-(IBAction) getPhoto {
    int count = [myArray1 count];
    //NSLog(@"%i",count);
    NSString *filename=[@"sb" stringByAppendingFormat:@"%d.png",count];
    NSLog(@"%@",filename);

    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;   
    
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:self.imgPicker animated:YES]; 
    
    ///////////////////////// SAVE PHOTO
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: 
                      [NSString stringWithString: filename] ];
    NSData* data = UIImagePNGRepresentation(image.image);
    [data writeToFile:path atomically:YES];
    
    UIImageWriteToSavedPhotosAlbum(image.image, nil, nil, nil);
    [myArray1 addObject:filename];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img  editingInfo:(NSDictionary *)editInfo {
    
    [picker dismissModalViewControllerAnimated:YES];
            //////create NSData
        NSLog(@"Camera called");
        NSData *ImageData = UIImageJPEGRepresentation(img, 0);
        [[NSUserDefaults  standardUserDefaults] setObject:ImageData forKey:@"image"];
        UIImage *scaledImage = [UIImage imageWithCGImage:[img CGImage] scale:5 orientation:UIImageOrientationRight];
    image.hidden = FALSE;
    image.image = scaledImage;

}
////////////////////////////

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
