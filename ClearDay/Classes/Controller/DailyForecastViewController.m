//
//  DailyForecastViewController.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 18/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "DailyForecastViewController.h"
#import "DailyDetailCell.h"
#import "DailyInfo.h"
#import "DailyInfoBuilder.h"
#import "DetailForecastViewController.h"
#import "DetailForecastInfo.h"

@interface DailyForecastViewController () <APICommunicatorDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSArray *dailyList;
}
@property (strong, nonatomic) IBOutlet UITableView *dailyTableView;

@end

@implementation DailyForecastViewController

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
    
    [WeatherAPI sharedInstance].delegate = self;
    if (self.cityID) {
        [[WeatherAPI sharedInstance] dailyForecastWeatherByCityId:self.cityID withCount:MAX_DAYS_FORECAST];
    } else {
        [[WeatherAPI sharedInstance] dailyForecastWeatherByCoordinate:self.cityCoordinates withCount:MAX_DAYS_FORECAST];
    }
}

#pragma mark
#pragma mark APICommunicator Delegate methods
-(void)receivedDataJSON:(NSData *)data {
    NSError *error = nil;
    
    dailyList = [DailyInfoBuilder getDailyListFromData:data error:error];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dailyTableView reloadData];
    });
}

-(void)fetchingDataFailedWithError:(NSError *)error {
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

#pragma mark
#pragma mark Table View Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dailyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    DailyInfo *info = dailyList[indexPath.row];
    
    [cell.dateLabel setText:info.date];
    [cell.shortDescriptionLabel setText:info.main];
    [cell.fullDescriptionLabel setText:info.description];
    [cell.weatherIcon setImage:info.weatherIcon];
    cell.detailForecastInfo = info.detailForecast;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyDetailCell *cell = (DailyDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailForecastViewController *detailForecastVC = (DetailForecastViewController *)[storyboard instantiateViewControllerWithIdentifier:@"detailForecast"];
    detailForecastVC.title = cell.dateLabel.text;
    detailForecastVC.detailForecastInfo = cell.detailForecastInfo;
    
    [self.navigationController pushViewController:detailForecastVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
