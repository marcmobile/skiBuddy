//
//  MapDetailViewController.h
//  skiBuddy
//
//  Created by Lui Marciante on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapDetailViewController : UIViewController <UIImagePickerControllerDelegate> {
    CLLocationManager *locationManager;
    MKMapView *myMapView;
    UILabel *stopWatchLabel;
    NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
    NSDate *startDate; // Stores the date of the click on the start button
    UIImagePickerController *imgPicker;
    IBOutlet UIButton *myRun;
    IBOutlet UIImageView *image;
    NSMutableArray *myArray;
    NSMutableArray *myArray1;
}

@property(nonatomic,strong) NSMutableArray *myArray;
@property(nonatomic,strong) NSMutableArray *myArray1;
@property (nonatomic, retain) IBOutlet UILabel *stopWatchLabel;
@property(strong,nonatomic) IBOutlet MKMapView *myMapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIImagePickerController *imgPicker;

-(IBAction)getPhoto;
-(IBAction)closeWindow;
-(IBAction)clickRun;

@end
