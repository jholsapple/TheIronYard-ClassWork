//
//  PinsViewController.m
//  Pickit
//
//  Created by John Holsapple on 7/29/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "PinsViewController.h"
#import "PicMark.h"
#import "CoreDataStack.h"

@import MapKit;
@import CoreLocation;

#define LAT_LNG_DEGREES 0.1

@interface PinsViewController () <MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
{
    MKMapView* _mapView;
    CLLocationManager * _locationManager;
    CLLocation *_currentLocation;
    NSMutableArray *_picmarks;
    CoreDataStack *cdStack;
}

@end

@implementation PinsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Pins";
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    _picmarks = [[NSMutableArray alloc] init];
    [self checkLocationAuthorization];
    
    cdStack = [CoreDataStack coreDataStackWithModelName:@"PickitModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhotoTapped:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"mapAnnotation"];
    
    if (!pinAnnotationView)
    {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapAnnotation"];
    }
    
    pinAnnotationView.canShowCallout = YES;
    PicMark *aPicMark = (PicMark *)annotation;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32.0, 32.0)];
    [imageView setImage: [aPicMark image];
    pinAnnotationView.leftCalloutAccessoryView = imageView;
    
    return pinAnnotationView;
}

#pragma  mark - CLLocation Related Methods

- (void)checkLocationAuthorization
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!_locationManager)
        {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (_locationManager)
    {
        if (enable)
        {
            [_locationManager startUpdatingLocation];
        }
        else
        {
            [_locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self enableLocationManager:YES];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *aLocation = [locations lastObject];
//    [self enableLocationManager:NO];
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(aLocation.coordinate, MKCoordinateSpanMake(LAT_LNG_DEGREES, LAT_LNG_DEGREES));
    [_mapView setRegion:mapRegion animated:YES];
    _currentLocation = aLocation;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        PicMark *aPicMark = [NSEntityDescription insertNewObjectForEntityForName:@"PicMark" inManagedObjectContext:cdStack.managedObjectContext];
        aPicMark.identifier = [NSString stringWithFormat:@"%@", [NSUUID UUID]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = paths[0];
        NSString *fullPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", aPicMark.identifier]];
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:fullPath atomically:YES];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Action Handlers

- (IBAction)addPhotoTapped:(UIBarButtonItem *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.delegate = self;
        imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePC animated:YES completion:nil];
    }
}


@end
