//
//  DetailForecastViewController.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "DetailForecastViewController.h"
#import "DetailForecastView.h"
#import "DetailForecastInfo.h"
#import "UIImage+Extensions.h"

@interface DetailForecastViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation DetailForecastViewController

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
    
    [self setUpValues];
}

-(void)setUpValues {
    self.detailView.tempMorningLabel.text = self.detailForecastInfo.tempMorning;
    self.detailView.tempDayLabel.text = self.detailForecastInfo.tempDay;
    self.detailView.tempEveningLabel.text = self.detailForecastInfo.tempEvening;
    self.detailView.tempNightLabel.text = self.detailForecastInfo.tempNight;
    self.detailView.humidityLabel.text = self.detailForecastInfo.humidity;
    self.detailView.pressureLabel.text = self.detailForecastInfo.pressure;
    self.detailView.cloudsLabel.text = self.detailForecastInfo.clouds;
    self.detailView.windSpeedLabel.text = self.detailForecastInfo.windSpeed;
    self.detailView.weatherIcon.image = self.detailForecastInfo.weatherIcon;
    
    float rotationDegree = [self.detailForecastInfo.windDegree floatValue];
    self.arrowImageView.image = [self.arrowImageView.image imageRotatedByDegrees:rotationDegree];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
