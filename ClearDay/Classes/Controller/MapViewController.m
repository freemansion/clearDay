//
//  MapViewController.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 17/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "MapViewController.h"
#import "DailyForecastViewController.h"

@interface MapViewController () {
    NSString *latStr;
    NSString *lonStr;
    MKPointAnnotation *pointAnnotation;
    CLLocationCoordinate2D tapPoint;
}
- (IBAction)forecastBtnTouch:(id)sender;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Pick place";
    _mapView.showsUserLocation = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:tapRecognizer];
}



-(void)foundTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self.mapView];
    tapPoint = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    if (pointAnnotation) {
        [self.mapView removeAnnotation:pointAnnotation];
    }
    pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = tapPoint;
    [self.mapView addAnnotation:pointAnnotation];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches){
        CGPoint pt = [touch  locationInView:_mapView];
        if (CGRectContainsPoint(_mapView.frame, pt)) {
            CLLocationCoordinate2D coord= [_mapView convertPoint:pt toCoordinateFromView:_mapView];
            latStr = [NSString stringWithFormat:@"%.2f", coord.latitude];
            lonStr = [NSString stringWithFormat:@"%.2f", coord.longitude];
            self.title = [NSString stringWithFormat:@"%@, %@", latStr, lonStr];
        
            NSLog(@"x=%f y=%f - lat=%f long = %f",pt.x,pt.y,coord.latitude,coord.longitude);
        }
    }
}

#pragma mark
#pragma mark IBAction methods
- (IBAction)currentBtnTouch:(id)sender {
    MKUserLocation *userLocation = _mapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate,
                                                                    20000,
                                                                    20000);
    [_mapView setRegion:region animated:NO];
}

- (IBAction)typeBtnTouch:(id)sender {
    if (_mapView.mapType == MKMapTypeStandard)
        _mapView.mapType = MKMapTypeSatellite;
    else
        _mapView.mapType = MKMapTypeStandard;
}

- (IBAction)forecastBtnTouch:(id)sender {
    if (!pointAnnotation) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear Day"
                                                        message:@"Add point first"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DailyForecastViewController *dailyForecastVC = (DailyForecastViewController *)[storyboard instantiateViewControllerWithIdentifier:@"dailyForecast"];
    dailyForecastVC.navigationItem.backBarButtonItem.title = @"Map";
    dailyForecastVC.cityCoordinates = tapPoint;
    [self.navigationController pushViewController:dailyForecastVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
