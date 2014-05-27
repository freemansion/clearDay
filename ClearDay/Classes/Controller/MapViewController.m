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
    [self.mapView addGestureRecognizer:tapRecognizer];
}

-(void)addPinToPointCoordinate:(CLLocationCoordinate2D)coordinate {
    // remove last pin if need
    if (pointAnnotation) {
        [self.mapView removeAnnotation:pointAnnotation];
    }
    pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = coordinate;
    [self.mapView addAnnotation:pointAnnotation];
    
    // update title
    latStr = [NSString stringWithFormat:@"%.2f", coordinate.latitude];
    lonStr = [NSString stringWithFormat:@"%.2f", coordinate.longitude];
    self.title = [NSString stringWithFormat:@"%@, %@", latStr, lonStr];
}

-(void)foundTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self.mapView];
    if (CGRectContainsPoint(self.mapView.frame, point)) {
        
        tapPoint = [self.mapView convertPoint:point toCoordinateFromView:self.view];
        
        [self addPinToPointCoordinate:tapPoint];
    }
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
